import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  List<Object> get props => [];
}

class SignupSubmitEvent extends SignupEvent {
  final String email;
  final String handle;
  final String password;
  SignupSubmitEvent(
      {@required this.email, @required this.handle, @required this.password});

  @override
  List<Object> get props => [email, handle, password];
}
