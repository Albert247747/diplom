import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class SuccessState extends HomeState {
  @override
  List<Object> get props => [];
}

class ErrorState extends HomeState {
  final String? messageError;

  ErrorState({this.messageError});

  @override
  List<Object> get props => [];
}
