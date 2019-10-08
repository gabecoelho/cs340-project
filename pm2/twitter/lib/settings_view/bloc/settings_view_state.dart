import 'package:equatable/equatable.dart';

abstract class SettingsViewState extends Equatable {
  const SettingsViewState();
}

class InitialSettingsViewState extends SettingsViewState {
  @override
  List<Object> get props => [];
}
