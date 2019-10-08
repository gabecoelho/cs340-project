import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).popAndPushNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
