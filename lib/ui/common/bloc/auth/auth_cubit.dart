import 'package:bloc/bloc.dart';
import 'package:diplom/ui/common/bloc/auth/auth_state.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/repositories/auth_repositories/auth_repositories.dart';

class CubitAuth extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  CubitAuth(this._authRepository) : super(LoginInitial());

  Future<void> checkCurrentUser() async {
    final firebaseUser = _authRepository.getCurrentFirebaseUser();

    if (firebaseUser == null) {
      emit(LoginInitial());
      return;
    }

    emit(LoginLoading());

    try {
      final user = await _authRepository.getUserModels(firebaseUser.uid);
      emit(LoginSuccess(user, user.isAdmin ? 'admin' : 'worker'));
    } catch (e) {
      await _authRepository.logout();
      emit(LoginError(t.error.authRestoreError, e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final user = await _authRepository.signIn(email, password);

      if (user.isAdmin) {
        emit(LoginSuccess(user, 'admin'));
      } else {
        emit(LoginSuccess(user, 'worker'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.code, e.message));
    } catch (e) {
      emit(LoginError('${t.error.loginError}: ${e.toString()}', e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginError(t.error.logoutError, e.toString()));
    }
  }
}
