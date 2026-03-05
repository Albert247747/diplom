import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CreateWorkerDataProvider {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CreateWorkerDataProvider(this._firestore);

  Future<void> createWorker({
    required Map<String, dynamic> dataUser,
    required String password,
    required String email,
  }) async {
    final createUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    final uuid = createUser.user!.uid;

    await _firestore.collection('Users').doc(uuid).set(dataUser);
  }
}
