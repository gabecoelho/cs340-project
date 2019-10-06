import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class Loading extends AuthState {
  Loading() : super([]);
}

class Idle extends AuthState {
  Idle() : super([]);
}

class Authenticated extends AuthState {
  // The data I want back from the authentication
  final String message;
  Authenticated({this.message}) : super([message]);
}

class Error extends AuthState {
  final String message;
  Error({this.message}) : super([message]);
}

abstract class AuthFormState extends AuthState {
  final String firstFieldLabel;
  final String buttonLabel;
  final String bottomTextLabel;
  AuthFormState(this.firstFieldLabel, this.buttonLabel, this.bottomTextLabel)
      : super([buttonLabel, firstFieldLabel, bottomTextLabel]);
}

class LoginFormDisplayed extends AuthFormState {
  final String handleLabel;
  final String loginButtonLabel;
  final String bottomTextLabel;
  LoginFormDisplayed(
      {this.handleLabel, this.loginButtonLabel, this.bottomTextLabel})
      : super(handleLabel, loginButtonLabel, bottomTextLabel);
}

class SignUpFormDisplayed extends AuthFormState {
  final String emailLabel;
  final String signUpButtonLabel;
  final String bottomTextLabel;
  SignUpFormDisplayed(
      {this.emailLabel, this.signUpButtonLabel, this.bottomTextLabel})
      : super(emailLabel, signUpButtonLabel, bottomTextLabel);
}

class NextPageState extends AuthState {}
