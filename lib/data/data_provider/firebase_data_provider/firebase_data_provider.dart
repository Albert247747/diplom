import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/domain/models/user/user_models.dart';
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

  Future<void> logout() async {
    await _auth.signOut();
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
