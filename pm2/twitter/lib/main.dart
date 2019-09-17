import 'package:flutter/material.dart';
import './view/login_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginView(title: 'Twitter'),
    );
  }
}

void main() => runApp(MyApp());
