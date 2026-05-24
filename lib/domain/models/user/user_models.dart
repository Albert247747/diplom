import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';

@freezed
abstract class UserModels with _$UserModels {
  const UserModels._();

  const factory UserModels({
    required String uid,
    required String email,
    required String name,
    required String lastName,
    required String surname,
    required String role,
  }) = _UserModels;

  factory UserModels.fromJson(String uid, Map<String, dynamic> data) {
    return UserModels(
      uid: uid,
      email: data['email'] as String? ?? '',
      name: data['name'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      surname: data['surname'] as String? ?? '',
      role: data['role'] as String? ?? '',
    );
  }

  bool get isAdmin => role == 'admin';

  bool get isWorker =>
      const {'worker', 'bartender', 'waiter', 'cook'}.contains(role);

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

  String get roleTitle {
    switch (role) {
      case 'admin':
        return 'Администратор';
      case 'bartender':
        return 'Бармен';
      case 'waiter':
        return 'Официант';
      case 'cook':
        return 'Повар';
      case 'worker':
        return 'Работник';
      default:
        return role;
    }
  }
}
