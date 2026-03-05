import 'package:diplom/data/repositories/create_worker_repositories/create_worker_data_repository.dart';
import 'package:diplom/ui/web/create_worker/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWorkerCubit extends Cubit<CreateWorkerState> {
  final CreateWorkerRepository _repository;

  CreateWorkerCubit(CreateWorkerRepository repository)
      : _repository = repository,
        super(InitialState());

      Future<void> createWorker(
          String email,
          String password,
          String role,
          String name,
          String lastName,
          String surname
          ) async {
        emit(LoadingState());
        try{
          final Map<String, dynamic> user = {
            'email': email,
            'role': role,
            'name': name,
            'lastName': lastName,
            'surname': surname
          };
        await _repository.saveWorker(
          email: email,
          userData: user,
            password: password
        );
        emit(SuccessState());
        } catch (e){
          emit(ErrorState(messageError: 'Ошибки создания'));
          Exception(e);
        }
      }
}