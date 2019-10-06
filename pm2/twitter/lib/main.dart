import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/auth/bloc/login_bloc.dart';
import 'package:twitter/auth/login_view.dart';
import 'package:twitter/home/bloc/bloc.dart';
import 'package:twitter/main_view/main_view.dart';
import 'package:twitter/profile_creation/bloc/bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register my providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          builder: (context) => ProfileBloc(),
        ),
        BlocProvider<HomeBloc>(
          builder: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        // home: LoginView(title: 'Twitter'),
        home: MainView(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (context) => LoginView(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        },
      ),
    );
  }
}

void main() => runApp(MyApp());
