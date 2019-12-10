import 'dart:async';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:twitter/services/real/user_service.dart';
import 'package:twitter/settings_view/bloc/settings_view_state.dart';
import './bloc.dart';

class SettingsViewBloc extends Bloc<SettingsViewEvent, SettingsViewState> {
  CognitoUser cognitoUser;
  UserService userService = UserService();

  @override
  SettingsViewState get initialState => SettingsViewInitialState();

  @override
  Stream<SettingsViewState> mapEventToState(
    SettingsViewEvent event,
  ) async* {
    if (event is SettingsViewSignOutEvent) {
      userService.signOut();

      yield SettingsViewSignOutState();
    }
  }
}
