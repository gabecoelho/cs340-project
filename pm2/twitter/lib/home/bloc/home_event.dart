import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeButtonPressedEvent extends HomeEvent {}

class SearchButtonPressedEvent extends HomeEvent {}

class NewTweetButtonPressedEvent extends HomeEvent {}

class ProfileButtonPressedEvent extends HomeEvent {}

class SettingsButtonPressedEvent extends HomeEvent {}
