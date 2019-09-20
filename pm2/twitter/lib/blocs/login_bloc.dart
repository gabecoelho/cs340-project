import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  Event
*/
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class LogIn extends AuthEvent {
  final String handle;
  final String password;
  LogIn({@required this.handle, @required this.password})
      : super([handle, password]);
}

class SignUp extends AuthEvent {
  final String email;
  final String password;
  SignUp({@required this.email, @required this.password})
      : super([email, password]);
}

class SwitchToLoginPressed extends AuthEvent {
  SwitchToLoginPressed() : super([]);
}

class SwitchToSignUpPressed extends AuthEvent {
  SwitchToSignUpPressed() : super([]);
}

/*
  State
*/
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

/*
  Bloc
*/
class LoginBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => SignUpFormDisplayed(
      emailLabel: "Email",
      signUpButtonLabel: "Sign Up",
      bottomTextLabel: "Already Have An Account? Log In Here");

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      // Call model
      if (event is SwitchToLoginPressed) {
        yield LoginFormDisplayed(
            handleLabel: "@Handle",
            loginButtonLabel: "Log In",
            bottomTextLabel: "New Here? Sign up with email!");
      }
      if (event is SwitchToSignUpPressed) {
        yield SignUpFormDisplayed(
            emailLabel: "Email",
            signUpButtonLabel: "Sign Up",
            bottomTextLabel: "Already Have An Account? Log In Here");
      }
    } catch (e) {
      yield Error(message: "Error");
    }
  }
}
