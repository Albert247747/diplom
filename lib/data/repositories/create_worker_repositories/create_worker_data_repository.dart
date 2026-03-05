import 'dart:math';

import 'package:diplom/data/data_provider/create_worker_data_provider/create_worker_data_provider.dart';

class CreateWorkerRepository {
  final CreateWorkerDataProvider _dataProvider;

  CreateWorkerRepository({
    required CreateWorkerDataProvider createWorkerDataProvider,
  }) : _dataProvider = createWorkerDataProvider;

  Future<void> saveWorker ({
    required Map<String, dynamic> userData,
    required String email,
    required String password,
  }) async {
    await _dataProvider.createWorker(
      dataUser:  userData,
      email: email,
      password: password
    );
  }
}
