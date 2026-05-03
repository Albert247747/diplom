import 'package:diplom/domain/models/user/user_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data_provider/firebase_data_provider/firebase_data_provider.dart';

class AuthRepository {
  final FirebaseDataProvider _dataProvider;

  AuthRepository({required FirebaseDataProvider firebaseAuth})
    : _dataProvider = firebaseAuth;

  Future<UserModels> signIn(String email, String password) async {
    final firebaseUser = await _dataProvider.signIn(email, password);
    return _dataProvider.getUserModels(firebaseUser.uid);
  }

  Future<void> logout() => _dataProvider.logout();

  Future<UserModels> getUserModels(String uuid) async =>
      await _dataProvider.getUserModels(uuid);

  User? getCurrentFirebaseUser() => _dataProvider.getCurrentUser();
}
