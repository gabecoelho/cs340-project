import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/settings_view/bloc/settings_view_state.dart';

import 'bloc/settings_view_bloc.dart';
import 'bloc/settings_view_event.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  AuthenticatedUserSingleton userModelSingleton = AuthenticatedUserSingleton();

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsViewBloc>(context);
    return BlocProvider(
      builder: (context) => settingsBloc,
      child: BlocListener(
        bloc: settingsBloc,
        listener: (context, state) {
          if (state is SettingsViewSignOutState) {
            Navigator.popAndPushNamed(context, '/login');
          }
        },
        child: BlocBuilder(
            bloc: settingsBloc,
            builder: (context, state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue,
                      onPressed: () {
                        settingsBloc.add(SettingsViewSignOutEvent());
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
