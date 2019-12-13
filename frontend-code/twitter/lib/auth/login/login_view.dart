import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/auth/signup/signup_view.dart';
import 'package:twitter/main_view/main_view.dart';
import 'package:twitter/widgets/twitter_button/twitter_button.dart';
import '../custom_route.dart';
import 'bloc/login_state.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  final String password = "";
  final String username = "";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  final _passwordFocusNode = FocusNode();

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  Widget _buildSubmitButton(BuildContext context, LoginState state) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return TwitterButton(
      borderColor: Colors.white,
      fillColor: Colors.white,
      textColor: Colors.teal,
      text: "Log in",
      onTap: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          loginBloc.add(LoginSubmitEvent(
              handle: _formData['handle'], password: _formData['password']));
        }
        if (state is LoginFailedState) {
          _showSnackBar(context, "Login Failed");
        }
      },
    );
  }

  Widget _buildForm(LoginState state, GlobalKey _formKey) {
    return Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    // hintText: "Handle",
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                onSaved: (String value) {
                  _formData['handle'] = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              // Password
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                focusNode: _passwordFocusNode,
                // validator: (String value) {
                //   return (value.isEmpty || value.length < 6)
                //       ? 'Password must have at least 6 letters.'
                //       : null;
                // },
                onSaved: (String value) {
                  _formData['password'] = value;
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildAlreadyHaveAnAccountButton(
      BuildContext context, LoginState state) {
    return FlatButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            NoAnimationMaterialPageRoute(builder: (context) => SignupView()));
      },
      child: Text(
        "New here? Sign up!",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: BlocProvider(
        builder: (context) => loginBloc,
        child: BlocListener(
          bloc: loginBloc,
          listener: (context, state) {
            if (state is NextPageFromLoginState) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainView()));
            }
          },
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
                      _buildForm(state, _formKey),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: _buildSubmitButton(context, state),
                      ),
                      // state is Authenticated ? Text(state.message) : Container(),
                      Spacer(),
                      _buildAlreadyHaveAnAccountButton(context, state),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'Dismiss', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter a valid email.';
  }

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Please enter a valid email';
  else
    return null;
}

String validateHandle(String value) {
  if (value.isEmpty) {
    return 'Please enter a valid \"handle\".';
  }

  Pattern pattern = r'^([A-Za-z0-9]{1,16})$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Please enter a valid \"handle\".';
  else
    return null;
}
