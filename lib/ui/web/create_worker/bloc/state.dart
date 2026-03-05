import 'package:equatable/equatable.dart';

abstract class CreateWorkerState extends Equatable{}
class InitialState extends CreateWorkerState {

  @override
  List<Object> get props => [];
}

class LoadingState extends CreateWorkerState {

  @override
  List<Object> get props => [];
}

class SuccessState extends CreateWorkerState {

  @override
  List<Object> get props => [];
}

class ErrorState extends CreateWorkerState {
  final String? messageError;

  ErrorState({this.messageError});

  @override
  List<Object> get props => [];
}
