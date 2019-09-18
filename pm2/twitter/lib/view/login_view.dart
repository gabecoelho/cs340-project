import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/widgets/login_button.dart';
import '../viewmodels/login_viewmodel.dart';
import 'package:bloc/bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String handle = "";
  final bool isLoginEnabled = false;
  final bool isSignupEnabled = false;
  final String password = "";
  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: BlocProvider(
        builder: (context) => loginBloc,
        child: BlocBuilder(
          bloc: loginBloc,
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue[400],
                    Colors.lightBlue,
                    Colors.lightBlue[300],
                    Colors.teal[300]
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                      size: 55.0,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildHandleField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildPasswordField(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: _buildSignupButton(context, "email", "pass"),
                    ),
                    state is Authenticated ? Text(state.message) : Container(),
                    Spacer(),
                    _buildLoginButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildLoginButton() {
  return FlatButton(
    onPressed: () {},
    child: Text(
      "Already have an account? Log in!",
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget _buildSignupButton(BuildContext context, String email, String password) {
  final loginBloc = BlocProvider.of<LoginBloc>(context);

  return LoginButton(
    borderColor: Colors.white,
    fillColor: Colors.white,
    textColor: Colors.teal,
    text: "Sign Up",
    onTap: () {
      loginBloc.dispatch(SignUp(email: email, password: password));
    },
  );
}

Widget _buildHandleField() {
  return CupertinoTextField(
    placeholder: "Email",
    style: TextStyle(color: Colors.white),
    placeholderStyle: TextStyle(color: Colors.white),
  );
}

Widget _buildPasswordField() {
  return CupertinoTextField(
    placeholder: "Password",
    style: TextStyle(color: Colors.white),
    placeholderStyle: TextStyle(color: Colors.white),
  );
}
