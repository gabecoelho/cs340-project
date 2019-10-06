import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'auth_event.dart';

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
      if (event is SignUpEvent) {
        yield NextPageState();
      }
      if (event is LogInEvent) {
        yield NextPageState();
      }
    } catch (e) {
      yield Error(message: "Error");
    }
  }
}
