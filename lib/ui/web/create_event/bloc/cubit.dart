import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data/repositories/create_event_repositories/create_event_data_repository.dart';
import 'package:diplom/ui/web/create_event/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  final CreateEventRepository _repository;

  CreateEventCubit(CreateEventRepository repository)
    : _repository = repository,
      super(CreateEventInitial());

  Future<void> createEvent({
    required String title,
    required String description,
    required String location,
    required DateTime date,
    required DateTime startAt,
    required DateTime endAt,
    required String role,
    required int workerCount,
    required int salary,
  }) async {
    emit(CreateEventLoading());
    try {
      final event = {
        'title': title,
        'description': description,
        'location': location,
        'date': Timestamp.fromDate(date),
        'startAt': Timestamp.fromDate(startAt),
        'endAt': Timestamp.fromDate(endAt),
        'role': role,
        'workerCount': workerCount,
        'salary': salary,
        'status': 'open',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _repository.saveEvent(eventData: event);
      emit(CreateEventSuccess());
    } catch (e) {
      emit(CreateEventError(messageError: e.toString()));
    }
  }
}
