import 'package:diplom/data/data_provider/create_event_data_provider/create_event_data_provider.dart';

class CreateEventRepository {
  final CreateEventDataProvider _dataProvider;

  CreateEventRepository({required CreateEventDataProvider dataProvider})
    : _dataProvider = dataProvider;

  Future<void> saveEvent({required Map<String, dynamic> eventData}) async {
    await _dataProvider.createEvent(eventData: eventData);
  }
}
