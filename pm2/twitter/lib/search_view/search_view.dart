import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
