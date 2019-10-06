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
    if (event is ProfileSubmitPressedEvent) {
      yield ProfileLoadingState();
      // Then go to the next page...
    }
    if (event is ProfilePictureChangedEvent) {
      yield ProfilePictureChangedState(image: event.image);
    }
  }
}
