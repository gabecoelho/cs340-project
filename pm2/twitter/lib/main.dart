import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/auth/bloc/login_bloc.dart';
import 'package:twitter/profile/bloc/bloc.dart';
import 'package:twitter/profile/profile_view.dart';
import './auth/login_view.dart';
import './home/home_view.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        // home: LoginView(title: 'Twitter'),
        home: HomeView(),
      ),
    );
  }
}

void main() => runApp(MyApp());
