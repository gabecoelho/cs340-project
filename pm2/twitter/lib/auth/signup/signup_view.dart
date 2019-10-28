import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/auth/custom_route.dart';
import 'package:twitter/auth/login/login_view.dart';
import 'package:twitter/profile_creation/profile_creation_view.dart';
import 'package:twitter/widgets/twitter_button/twitter_button.dart';
import 'bloc/signup_state.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_event.dart';

class SignupView extends StatefulWidget {
  SignupView({Key key}) : super(key: key);

  final String password = "";
  final String username = "";

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  final _passwordFocusNode = FocusNode();

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };

  Widget _buildSubmitButton(BuildContext context, SignupState state) {
    final signupBloc = BlocProvider.of<SignupBloc>(context);

    return TwitterButton(
      borderColor: Colors.white,
      fillColor: Colors.white,
      textColor: Colors.teal,
      text: "Sign up",
      onTap: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          signupBloc.add(
            SignupSubmitEvent(
              email: _formData['email'],
              handle: _formData['handle'],
              password: _formData['password'],
            ),
          );
        }
      },
    );
  }

  Widget _buildForm(SignupState state, GlobalKey _formKey) {
    return Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: TextFormField(
                validator: (String value) {
                  return validateEmail(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                onSaved: (String value) {
                  _formData['email'] = value;
                },
              ),
            ),
            TextFormField(
              validator: (String value) {
                return validateHandle(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "@Handle",
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
              onSaved: (String value) {
                _formData['handle'] = value;
              },
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
                validator: (String value) {
                  return (value.isEmpty || value.length < 8)
                      ? 'Password must have at least 8 letters.'
                      : null;
                },
                onSaved: (String value) {
                  _formData['password'] = value;
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildAlreadyHaveAnAccountButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          NoAnimationMaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      },
      child: Text(
        "Already have an account? Log in!",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signupBloc = BlocProvider.of<SignupBloc>(context);

    return Scaffold(
      body: BlocProvider(
        builder: (context) => signupBloc,
        child: BlocListener(
          bloc: signupBloc,
          listener: (context, state) {
            if (state is NextPageFromSignupState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfileView()));
            }
          },
          child: BlocBuilder(
            bloc: signupBloc,
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
                      Spacer(),
                      _buildAlreadyHaveAnAccountButton(context),
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
    return 'Please enter a valid \"@handle\".';
  }

  Pattern pattern = r'^@([A-Za-z0-9]{1,16})$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Please enter a valid \"@handle\".';
  else
    return null;
}
