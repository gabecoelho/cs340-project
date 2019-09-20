import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/blocs/login_bloc.dart';
import './view/login_view.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Register my providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: LoginView(title: 'Twitter'),
      ),
    );
  }
}

void main() => runApp(MyApp());
