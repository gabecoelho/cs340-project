import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class LogInEvent extends AuthEvent {
  final String handle;
  final String password;
  LogInEvent({@required this.handle, @required this.password})
      : super([handle, password]);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpEvent({@required this.email, @required this.password})
      : super([email, password]);
}

class SwitchToLoginPressed extends AuthEvent {
  SwitchToLoginPressed() : super([]);
}

class SwitchToSignUpPressed extends AuthEvent {
  SwitchToSignUpPressed() : super([]);
}
