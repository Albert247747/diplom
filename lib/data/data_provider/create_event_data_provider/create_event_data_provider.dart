import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEventDataProvider {
  final FirebaseFirestore _firestore;

  CreateEventDataProvider(this._firestore);

  Future<void> createEvent({required Map<String, dynamic> eventData}) async {
    await _firestore.collection('events').add(eventData);
  }
}
