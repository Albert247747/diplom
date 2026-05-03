import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CreateWorkerDataProvider {
  final FirebaseFirestore _firestore;

  CreateWorkerDataProvider(this._firestore);

  Future<void> createWorker({
    required Map<String, dynamic> dataUser,
    required String password,
    required String email,
  }) async {
    final auth = await _secondaryAuth();
    final createUser = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uuid = createUser.user!.uid;
    await auth.signOut();

    await _firestore.collection('Users').doc(uuid).set(dataUser);
  }

  Future<FirebaseAuth> _secondaryAuth() async {
    const appName = 'create-worker';

    try {
      return FirebaseAuth.instanceFor(app: Firebase.app(appName));
    } on FirebaseException catch (e) {
      if (e.code != 'no-app') {
        rethrow;
      }
    }

    final app = await Firebase.initializeApp(
      name: appName,
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseAuth.instanceFor(app: app);
  }
}
