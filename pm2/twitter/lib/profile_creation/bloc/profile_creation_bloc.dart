import 'dart:async';
import 'package:bloc/bloc.dart';
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
      print('from bloc: ${event.name}');

      if (await userService.signUp(
              event.email, event.password, event.name, event.handle) !=
          null) {
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
