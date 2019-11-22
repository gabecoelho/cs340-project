import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/services/real/user_service.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmitEvent) {
      print(event.handle);
      UserService userService = UserService();
      if (await userService.signIn(event.handle, event.password) != null) {
        yield NextPageFromLoginState();
      } else {
        yield LoginFailedState();
      }
    }
  }
}
