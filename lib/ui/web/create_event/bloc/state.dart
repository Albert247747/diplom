import 'package:equatable/equatable.dart';

abstract class CreateEventState extends Equatable {}

class CreateEventInitial extends CreateEventState {
  @override
  List<Object> get props => [];
}

class CreateEventLoading extends CreateEventState {
  @override
  List<Object> get props => [];
}

class CreateEventSuccess extends CreateEventState {
  @override
  List<Object> get props => [];
}

class CreateEventError extends CreateEventState {
  final String? messageError;

  CreateEventError({this.messageError});

  @override
  List<Object> get props => [];
}
