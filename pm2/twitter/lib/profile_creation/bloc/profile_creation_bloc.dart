import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/real/user_service.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileInitialState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    yield ProfileInitialState();

    if (event is ProfileSubmitPressedEvent) {
      UserService userService = UserService();

      User user = await userService.signUp(event.email, event.password,
          event.name, event.handle, event.base64EncodedString);

      if (user != null) {
        AuthenticatedUserSingleton userModelSingleton =
            AuthenticatedUserSingleton();

        userModelSingleton.authenticatedUser.user.handle = user.handle;
        userModelSingleton.authenticatedUser.user.name = user.name;
        userModelSingleton.authenticatedUser.user.picture = user.picture;

        yield ProfileSubmitState();
      } else {
        // yield Loading
      }
    }
    if (event is ProfilePictureChangedEvent) {
      yield ProfilePictureChangedState(image: event.image);
    }
  }
}
