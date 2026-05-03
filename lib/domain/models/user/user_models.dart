import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';

@freezed
abstract class UserModels with _$UserModels {
  const UserModels._();

  const factory UserModels({required String uid, required String role}) =
      _UserModels;

  factory UserModels.fromJson(String uid, Map<String, dynamic> data) {
    return UserModels(uid: uid, role: data['role'] as String? ?? '');
  }

  bool get isAdmin => role == 'admin';

  bool get isWorker =>
      const {'worker', 'bartender', 'waiter', 'cook'}.contains(role);
}
