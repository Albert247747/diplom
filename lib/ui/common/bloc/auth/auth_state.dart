import 'package:diplom/domain/models/user/user_models.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class LoginInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthState {
  final UserModels users;

  final String route;

  LoginSuccess(this.users, this.route);

  @override
  List<Object> get props => [users];
}

class LoginError extends AuthState {
  final String errorCode;
  final String? errorMessage;

  LoginError(this.errorCode, this.errorMessage);

  @override
  List<Object> get props => [];
}
