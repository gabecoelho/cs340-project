import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const <dynamic>[]]) : super(props);
}

class ProfileSubmitPressedEvent extends ProfileEvent {}

class ProfilePictureChangedEvent extends ProfileEvent {
  final File image;

  ProfilePictureChangedEvent({@required this.image}) : super([image]);
}
