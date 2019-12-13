import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
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
      UserService userService = UserService();

      User user = await userService.signIn(event.handle, event.password);
    
      if (user != null) {
        AuthenticatedUserSingleton userModelSingleton =
            AuthenticatedUserSingleton();

        userModelSingleton.authenticatedUser.user.handle = user.handle;
        userModelSingleton.authenticatedUser.user.name = user.name;
        userModelSingleton.authenticatedUser.user.picture = user.picture;

        yield NextPageFromLoginState();
      } else {
        yield LoginFailedState();
      }
    }
  }
}
