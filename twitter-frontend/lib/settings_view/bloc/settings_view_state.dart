import 'package:equatable/equatable.dart';

abstract class SettingsViewState extends Equatable {
  const SettingsViewState();

  List<Object> get props => [];
}

class SettingsViewInitialState extends SettingsViewState {
  @override
  List<Object> get props => [];
}

class SettingsViewSignOutState extends SettingsViewState {
  SettingsViewSignOutState();
}
