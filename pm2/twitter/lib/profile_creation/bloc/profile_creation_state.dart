import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:io';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const <dynamic>[]]) : super(props);
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ProfilePictureChangedState extends ProfileState {
  final File image;

  ProfilePictureChangedState({@required this.image}) : super([image]);
}

class ProfileSubmitState extends ProfileState {}
