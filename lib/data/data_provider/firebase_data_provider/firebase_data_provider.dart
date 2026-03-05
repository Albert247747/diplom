

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/domain/models/user/userModels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseDataProvider{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 Future<User> signIn(String email, String password)
 async {
   final result = await _auth.signInWithEmailAndPassword(
       email: email,
       password: password );
  final user = result.user;

  if(user == null){
    throw Exception("Аутентифицированный пользователь, не найден");
  }
  // final uuid =  user.uid;
  return user;
 }

 User? getCurrentUser ()  {
   return _auth.currentUser;
 }

 Future<UserModels> getUserModels(String uid) async {

   final getUid = await _firestore.collection('Users').doc(uid).get();
   if(!getUid.exists){
     throw Exception('USER_NOT_IN_DB');
   }

   return UserModels.fromJson(uid, getUid.data()!);
 }

 Future<void> logout() async {
   try {
     await _auth.signOut();
   } catch(e){
     throw Exception(e);
   }
 }
}