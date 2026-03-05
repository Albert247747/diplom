import 'package:equatable/equatable.dart';

abstract class StateAuth extends Equatable{}
class LoginInitial extends StateAuth {

  @override
  List<Object> get props => [];
}

  class LoginLoading extends StateAuth {

  @override
  List<Object> get props => [];
}

class LoginSuccess extends StateAuth {

  @override
  List<Object> get props => [];
}

class LoginError extends StateAuth {
  final String? messageError;

  LoginError({this.messageError});

  @override
  List<Object> get props => [];
}
