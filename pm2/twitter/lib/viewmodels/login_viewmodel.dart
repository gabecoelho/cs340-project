import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  EVENT
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

/*
  STATE
*/
abstract class AuthState extends AuthEvent {
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

/*
  BLOC
*/
class LoginBloc extends Bloc<AuthEvent, AuthState> {
  @override
  // TODO: implement initialState
  AuthState get initialState => Idle();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // TODO: implement mapEventToState
    try {
      // Call model
      yield Authenticated(message: "User Authenticated");
    } catch (e) {}
    yield Error(message: "Error");
  }
}

class LoginViewModel extends StatefulWidget {
  final String handle = "";
  final String password = "";

  final bool isLoginEnabled = false;

  const LoginViewModel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: child,
        );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
