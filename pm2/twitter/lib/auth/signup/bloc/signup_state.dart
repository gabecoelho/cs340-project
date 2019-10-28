import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  List<Object> get props => null;
}

class SignupInitialState extends SignupState {}

class NextPageFromSignupState extends SignupState {}
