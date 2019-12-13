import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  List<Object> get props => [];
}

class InitialUserProfileState extends UserProfileState {}
