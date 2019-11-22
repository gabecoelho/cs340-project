import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  List<Object> get props => null;
}

class LoginInitialState extends LoginState {}

class LoginFailedState extends LoginState {
  final message;

  LoginFailedState({this.message});

  @override
  List<Object> get props => [message];
}

class NextPageFromLoginState extends LoginState {}
