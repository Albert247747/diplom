import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/domain/models/event/event_model.dart';

class WorkerModel {
  const WorkerModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.lastName,
    required this.surname,
    required this.role,
  });

  final String uid;
  final String email;
  final String name;
  final String lastName;
  final String surname;
  final String role;

  factory WorkerModel.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return WorkerModel(
      uid: doc.id,
      email: data['email'] as String? ?? '',
      name: data['name'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      surname: data['surname'] as String? ?? '',
      role: data['role'] as String? ?? '',
    );
  }

  String get fullName {
    final value = [
      lastName,
      name,
      surname,
    ].where((part) => part.trim().isNotEmpty).join(' ');

    if (value.isNotEmpty) {
      return value;
    }

    return email.isEmpty ? 'Без имени' : email;
  }

  String get roleTitle => EventModel.roleTitleFromRole(role);
}
