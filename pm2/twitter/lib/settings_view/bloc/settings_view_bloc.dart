import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SettingsViewBloc extends Bloc<SettingsViewEvent, SettingsViewState> {
  @override
  SettingsViewState get initialState => InitialSettingsViewState();

  @override
  Stream<SettingsViewState> mapEventToState(
    SettingsViewEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
