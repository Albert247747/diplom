import 'package:bloc/bloc.dart';
import 'package:diplom/ui/web/signIn/bloc/sign_in_state.dart';
import '../../../../data/repositories/auth_repositories/auth_repositories.dart';

  class CubitAuth extends Cubit<StateAuth> {
    final AuthRepository _authRepository;

    CubitAuth(AuthRepository repository)
        : _authRepository = repository,
          super(LoginInitial());


   Future<void> login(String email, String password)  async {
      emit(LoginLoading());
    try{
    // final user = await _authRepository.signIn(email, password);
    // if(user.isAdmin && isWeb){
    //   emit(LoginSuccess());
    // }
    // if(user.isWorker && isMobile)
      emit(LoginSuccess());
    } catch (e)  {
      emit(LoginError(messageError: 'Доступ разрешен только администраторам'));
    }
   }

   Future<void> logout() async {
      try {
        await _authRepository.logout();
        emit(LoginInitial());
      } on Exception catch (e) {
        print('error');
      }
   }

  }