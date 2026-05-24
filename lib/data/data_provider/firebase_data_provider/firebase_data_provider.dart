import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/domain/models/event/event_model.dart';
import 'package:diplom/domain/models/user/user_models.dart';
import 'package:diplom/domain/models/worker/worker_model.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModels> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw Exception('USER_NULL');
      }

      return await _getUserFromFirestore(firebaseUser.uid);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: _mapFirebaseError(e.code),
      );
    } catch (e) {
      throw Exception('UNKNOWN_ERROR: $e');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserModels> getUserModels(String uid) async {
    return await _getUserFromFirestore(uid);
  }

  Stream<UserModels> watchCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error(Exception('Пользователь не авторизован'));
    }

    return _firestore.collection('Users').doc(user.uid).snapshots().map((doc) {
      final data = doc.data();

      if (!doc.exists || data == null) {
        throw Exception('USER_NOT_IN_DB');
      }

      return UserModels.fromJson(doc.id, data);
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<List<WorkerModel>> watchWorkers() {
    return _firestore
        .collection('Users')
        .where('role', whereIn: const ['worker', 'bartender', 'waiter', 'cook'])
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(WorkerModel.fromFirestore).toList()
                ..sort((a, b) => a.fullName.compareTo(b.fullName)),
        );
  }

  Future<void> deleteWorker(String uid) async {
    final userRef = _firestore.collection('Users').doc(uid);
    final eventsSnapshot =
        await _firestore
            .collection('events')
            .where('assignedWorkerIds', arrayContains: uid)
            .get();
    final batch = _firestore.batch();

    batch.delete(userRef);

    for (final eventDoc in eventsSnapshot.docs) {
      final data = eventDoc.data();
      final assignedWorkers =
          (data['assignedWorkers'] as List?)
              ?.whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .where((worker) => worker['uid']?.toString() != uid)
              .toList() ??
          <Map<String, dynamic>>[];

      batch.update(eventDoc.reference, {
        'assignedWorkerIds': FieldValue.arrayRemove([uid]),
        'assignedWorkers': assignedWorkers,
      });
    }

    await batch.commit();
  }

  Stream<List<EventModel>> watchEvents() {
    return _firestore
        .collection('events')
        .orderBy('date')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(EventModel.fromFirestore).toList(),
        );
  }

  Stream<List<EventModel>> watchWorkerEvents() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error(Exception('Пользователь не авторизован'));
    }

    return _firestore.collection('Users').doc(user.uid).snapshots().asyncExpand(
      (userDoc) {
        final userData = userDoc.data() ?? <String, dynamic>{};
        final role = userData['role']?.toString() ?? '';

        return watchEvents().map(
          (events) => events.where((event) => event.role == role).toList(),
        );
      },
    );
  }

  Stream<List<EventModel>> watchBookedEvents() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error(Exception('Пользователь не авторизован'));
    }

    return watchEvents().map(
      (events) => events.where((event) => event.isBookedBy(user.uid)).toList(),
    );
  }

  Stream<EventModel?> watchEvent(String eventId) {
    return _firestore.collection('events').doc(eventId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return EventModel.fromFirestore(doc);
    });
  }

  Future<void> bookEvent(String eventId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }

    final userDoc = await _firestore.collection('Users').doc(user.uid).get();
    final userData = userDoc.data() ?? <String, dynamic>{};
    final userRole = userData['role']?.toString() ?? '';
    final workerData = <String, dynamic>{
      'uid': user.uid,
      'email': user.email ?? userData['email'] ?? '',
      'name': userData['name'] ?? '',
      'lastName': userData['lastName'] ?? '',
      'surname': userData['surname'] ?? '',
      'role': userData['role'] ?? '',
      'bookedAt': Timestamp.now(),
    };

    final eventRef = _firestore.collection('events').doc(eventId);

    await _firestore.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventRef);

      if (!eventDoc.exists) {
        throw Exception('Мероприятие не найдено');
      }

      final data = eventDoc.data() ?? <String, dynamic>{};
      final eventRole = data['role']?.toString() ?? '';
      final workerCount = (data['workerCount'] as num?)?.toInt() ?? 0;
      final assignedWorkerIds =
          (data['assignedWorkerIds'] as List?)
              ?.map((id) => id.toString())
              .toSet() ??
          <String>{};
      final assignedWorkers =
          (data['assignedWorkers'] as List?)
              ?.whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList() ??
          <Map<String, dynamic>>[];

      if (assignedWorkerIds.isEmpty) {
        assignedWorkerIds.addAll(
          assignedWorkers
              .map((worker) => worker['uid']?.toString() ?? '')
              .where((uid) => uid.isNotEmpty),
        );
      }

      if (assignedWorkerIds.contains(user.uid)) {
        throw Exception('Вы уже записаны на эту смену');
      }

      if (eventRole.isNotEmpty && eventRole != userRole) {
        throw Exception('Ваша должность не подходит для этой смены');
      }

      if (workerCount > 0 && assignedWorkerIds.length >= workerCount) {
        throw Exception('На эту смену уже нет свободных мест');
      }

      transaction.update(eventRef, {
        'assignedWorkerIds': FieldValue.arrayUnion([user.uid]),
        'assignedWorkers': FieldValue.arrayUnion([workerData]),
      });
    });
  }

  Future<void> cancelEventBooking(String eventId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }

    final eventRef = _firestore.collection('events').doc(eventId);

    await _firestore.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventRef);

      if (!eventDoc.exists) {
        throw Exception('Мероприятие не найдено');
      }

      final data = eventDoc.data() ?? <String, dynamic>{};
      final assignedWorkers =
          (data['assignedWorkers'] as List?)
              ?.whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList() ??
          <Map<String, dynamic>>[];
      Map<String, dynamic>? currentWorker;

      for (final worker in assignedWorkers) {
        if (worker['uid']?.toString() == user.uid) {
          currentWorker = worker;
          break;
        }
      }

      final updateData = <String, dynamic>{
        'assignedWorkerIds': FieldValue.arrayRemove([user.uid]),
      };

      if (currentWorker != null) {
        updateData['assignedWorkers'] = FieldValue.arrayRemove([currentWorker]);
      }

      transaction.update(eventRef, updateData);
    });
  }

  Future<UserModels> _getUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('Users').doc(uid).get();

    if (!doc.exists) {
      throw Exception('USER_NOT_IN_DB');
    }

    final data = doc.data();

    if (data == null) {
      throw Exception('USER_DATA_NULL');
    }

    return UserModels.fromJson(uid, data);
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return t.error.userNotFound;
      case 'wrong-password':
        return t.error.wrongPassword;
      case 'invalid-email':
        return t.error.invalidEmail;
      case 'email-already-in-use':
        return t.error.emailAlreadyInUse;
      case 'weak-password':
        return t.error.weakPassword;
      case 'network-request-failed':
        return t.error.networkRequestFailed;
      default:
        return t.error.unknownAuthError;
    }
  }
}
