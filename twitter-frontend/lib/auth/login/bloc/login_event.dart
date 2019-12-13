import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final String handle;
  final String password;
  LoginSubmitEvent({@required this.handle, @required this.password});

  @override
  List<Object> get props => [handle, password];
}
