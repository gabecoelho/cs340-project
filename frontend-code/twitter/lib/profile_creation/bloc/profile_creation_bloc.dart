import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/real/user_service.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileInitialState();
  UserService userService = UserService();
  ServiceFacade serviceFacade = ServiceFacade();
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    yield ProfileInitialState();

    if (event is ProfileSubmitPressedEvent) {
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

    // From User_Profile_View
    if (event is UserProfileChangedPictureEvent) {
      String result = await serviceFacade.uploadPicture(
          event.handle, event.base64EncodedString);

      yield UserProfilePictureChangedState(newImageUrl: result);
    }
  }
}
