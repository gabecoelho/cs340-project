import 'package:equatable/equatable.dart';

abstract class SettingsViewEvent extends Equatable {
  const SettingsViewEvent();

  List<Object> get props => null;
}

class SettingsViewSignOutEvent extends SettingsViewEvent {
  SettingsViewSignOutEvent();

  @override
  List<Object> get props => [];
}
