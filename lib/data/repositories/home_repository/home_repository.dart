import 'package:diplom/data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import 'package:diplom/domain/models/event/event_model.dart';

class HomeRepository {
  final FirebaseDataProvider _provider;

  HomeRepository({required FirebaseDataProvider provider})
    : _provider = provider;

  Future<void> logout() async {
    await _provider.logout();
  }

  Stream<List<EventModel>> watchEvents() {
    return _provider.watchEvents();
  }

  Stream<List<EventModel>> watchWorkerEvents() {
    return _provider.watchWorkerEvents();
  }

  Stream<EventModel?> watchEvent(String eventId) {
    return _provider.watchEvent(eventId);
  }

  Future<void> bookEvent(String eventId) async {
    await _provider.bookEvent(eventId);
  }

  Future<void> cancelEventBooking(String eventId) async {
    await _provider.cancelEventBooking(eventId);
  }
}
