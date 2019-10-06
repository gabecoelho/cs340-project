import 'package:equatable/equatable.dart';

abstract class MainViewState extends Equatable {
  const MainViewState();
}

class MainViewInitialState extends MainViewState {
  @override
  List<Object> get props => [];
}

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
