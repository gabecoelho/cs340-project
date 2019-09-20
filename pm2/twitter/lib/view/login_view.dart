import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/widgets/twitter_button.dart';
import '../blocs/login_bloc.dart';
import 'package:bloc/bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String username = "";
  final String password = "";
  final String title;
  final bool isLoginEnabled = false;
  final bool isSignupEnabled = false;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  void dispose() {
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

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
                    _buildForm(state),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: _buildSignUpButton(
                          context,
                          usernameFieldController.text,
                          passwordFieldController.text,
                          state),
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
    );
  }
}

Widget _buildAlreadyHaveAnAccountButton(BuildContext context, AuthState state) {
  final loginBloc = BlocProvider.of<LoginBloc>(context);

  return FlatButton(
    onPressed: () {
      loginBloc.dispatch(
        state is SignUpFormDisplayed
            ? SwitchToLoginPressed()
            : SwitchToSignUpPressed(),
      );
    },
    child: Text(
      state is AuthFormState ? state.bottomTextLabel : "",
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget _buildSignUpButton(
    BuildContext context, String email, String password, AuthState state) {
  final loginBloc = BlocProvider.of<LoginBloc>(context);

  return TwitterButton(
    borderColor: Colors.white,
    fillColor: Colors.white,
    textColor: Colors.teal,
    text: state is AuthFormState ? state.buttonLabel : "",
    onTap: () {
      loginBloc.dispatch(SignUp(email: email, password: password));
    },
  );
}

Widget _buildForm(AuthState state) {
  return Form(
      child: new ListView(
    shrinkWrap: true,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: state is AuthFormState ? state.firstFieldLabel : "",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  ));
}
