import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:io';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => null;
}

class ProfileLoadedState extends ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ProfilePictureChangedState extends ProfileState {
  final File image;
  ProfilePictureChangedState({@required this.image});

  @override
  List<Object> get props => [image];
}

// From User_Profile_View
class UserProfilePictureChangedState extends ProfileState {
  final String newImageUrl;

  UserProfilePictureChangedState({@required this.newImageUrl});

  List<Object> get props => [newImageUrl];
}

class ProfileSubmitState extends ProfileState {}
