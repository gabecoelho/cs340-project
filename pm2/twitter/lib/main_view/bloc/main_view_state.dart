import 'package:equatable/equatable.dart';

abstract class MainViewState extends Equatable {
  const MainViewState();

  List<Object> get props => null;
}

class MainViewInitialState extends MainViewState {}

class SearchButtonPressedState extends MainViewState {
  // Navigate to search view
}

class NewTweetButtonPressedState extends MainViewState {
  // Navigate to new tweet view
}

class ProfileButtonPressedState extends MainViewState {
  // Navigate to profile view
}

class SettingsButtonPressedState extends MainViewState {
  // Navigate to settings view
}
