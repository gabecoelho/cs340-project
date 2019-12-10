import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twitter/auth/login/bloc/login_bloc.dart';
import 'package:twitter/auth/login/login_view.dart';
import 'package:twitter/auth/signup/bloc/signup_bloc.dart';
import 'package:twitter/home/bloc/bloc.dart';
import 'package:twitter/main_view/main_view.dart';
import 'package:twitter/profile_creation/bloc/bloc.dart';
import 'package:twitter/settings_view/bloc/settings_view_bloc.dart';
import 'package:twitter/single_user_view/bloc/single_user_view_bloc.dart';
import 'package:twitter/widgets/user_cell/bloc/user_cell_bloc.dart';

import 'auth/signup/signup_view.dart';
import 'new_tweet/bloc/new_tweet_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register my providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (context) => LoginBloc(),
        ),
        BlocProvider<SignupBloc>(
          builder: (context) => SignupBloc(),
        ),
        BlocProvider<ProfileBloc>(
          builder: (context) => ProfileBloc(),
        ),
        BlocProvider<HomeBloc>(
          builder: (context) => HomeBloc(),
        ),
        BlocProvider<NewTweetBloc>(
          builder: (context) => NewTweetBloc(),
        ),
        BlocProvider<SettingsViewBloc>(
          builder: (context) => SettingsViewBloc(),
        ),
        BlocProvider<SingleUserViewBloc>(
          builder: (context) => SingleUserViewBloc(),
        ),
        BlocProvider<UserCellBloc>(
          builder: (context) => UserCellBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: SignupView(),
        routes: {
          '/signup': (context) => SignupView(),
          '/login': (context) => LoginView(),
          '/main': (context) => MainView(),
        },
      ),
    );
  }
}

void main() => runApp(MyApp());
