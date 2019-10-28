import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => null;
}

class HomeInitialState extends HomeState {}

class SearchButtonPressedState extends HomeState {
  // Navigate to search view
}

class NewTweetButtonPressedState extends HomeState {
  // Navigate to new tweet view
}

class ProfileButtonPressedState extends HomeState {
  // Navigate to profile view
}

class SettingsButtonPressedState extends HomeState {
  // Navigate to settings view
}
