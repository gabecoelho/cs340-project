import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const <dynamic>[]]);

  List<Object> get props => null;
}

class ProfileInitialEvent extends ProfileEvent {}

class ProfileSubmitPressedEvent extends ProfileEvent {
  final String email;
  final String password;
  final String name;
  final String handle;
  final String base64EncodedString;

  ProfileSubmitPressedEvent(
      {@required this.email,
      @required this.password,
      @required this.name,
      @required this.handle,
      @required this.base64EncodedString});

  @override
  List<Object> get props =>
      [email, password, name, handle, base64EncodedString];
}

class ProfilePictureChangedEvent extends ProfileEvent {
  final File image;

  ProfilePictureChangedEvent({@required this.image});

  @override
  List<Object> get props => [image];
}

// From User_Profile_View
class UserProfileChangedPictureEvent extends ProfileEvent {
  final String base64EncodedString;
  final String handle;

  UserProfileChangedPictureEvent(
      {@required this.handle, this.base64EncodedString});

  @override
  List<Object> get props => [handle, base64EncodedString];
}
