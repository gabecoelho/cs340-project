import 'dart:async';
import 'package:bloc/bloc.dart';
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
      yield ProfileSubmitState();
    }
    if (event is ProfilePictureChangedEvent) {
      yield ProfilePictureChangedState(image: event.image);
    }
  }
}