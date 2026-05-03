import 'package:diplom/utils/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseValidation {
  /// Не забыть, добавить валидацию для создания сотрудника (На админке)
  /// Не забыть добавить валидацию для входа, такого пользователя не существует
  String email = '';
  String password = '';

  final Map<String, List<String>> errors = {};

  void _addError(String field, String message) {
    errors.putIfAbsent(field, () => []).add(message);
  }

  bool validate() {
    bool isValid = true;
    errors.clear();

    if (email.isEmpty) {
      isValid = false;
      _addError('email', t.validation.enterEmail);
    } else {
      final emailRegExp = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');
      if (!emailRegExp.hasMatch(email)) {
        isValid = false;
        _addError('email', t.validation.invalidEmailFormat);
      }
    }
    if (password.isEmpty) {
      isValid = false;
      _addError('password', t.validation.enterPassword);
    } else if (password.length < 6) {
      isValid = false;
      _addError('password', t.validation.minPasswordLength);
    }

    return isValid;
  }

  void handleFirebaseError(Object error) {
    errors.clear();

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          _addError('email', t.validation.emailAlreadyRegistered);
          break;
        case 'invalid-email':
          _addError('email', t.validation.invalidEmailFormat);
          break;
        case 'user-not-found':
          _addError('email', t.validation.userWithEmailNotFound);
          break;
        case 'wrong-password':
          _addError('password', t.error.wrongPassword);
          break;
        case 'weak-password':
          _addError('password', t.error.weakPassword);
          break;
        case 'too-many-requests':
          _addError('email', t.validation.tooManyRequests);
          _addError('password', t.validation.tooManyRequests);
          break;
        case 'network-request-failed':
          _addError('email', t.validation.checkInternet);
          _addError('password', t.validation.checkInternet);
          break;
        default:
          _addError('email', '${t.validation.genericError}: ${error.message}');
      }
    } else {
      _addError('email', t.validation.unknownError);
    }
  }
}
