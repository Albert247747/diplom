import 'package:bloc/bloc.dart';
import 'package:diplom/domain/models/event/event_model.dart';
import 'package:diplom/ui/mobile/main_screen/bloc/home_state.dart';

import '../../../../data/repositories/home_repository/home_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit(HomeRepository repository)
    : _repository = repository,
      super(InitialState());

  Future<void> logout() async {
    emit(LoadingState());
    try {
      await _repository.logout();
      emit(SuccessState());
    } on Exception {
      emit(ErrorState(messageError: "Ошибка выхода с аккаунта"));
    }
  }

  Stream<List<EventModel>> watchEvents() {
    return _repository.watchEvents();
  }

  Stream<List<EventModel>> watchWorkerEvents() {
    return _repository.watchWorkerEvents();
  }

  Stream<EventModel?> watchEvent(String eventId) {
    return _repository.watchEvent(eventId);
  }

  Future<void> bookEvent(String eventId) async {
    await _repository.bookEvent(eventId);
  }

  Future<void> cancelEventBooking(String eventId) async {
    await _repository.cancelEventBooking(eventId);
  }
}
