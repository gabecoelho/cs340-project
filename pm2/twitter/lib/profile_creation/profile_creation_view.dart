import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/auth/bloc.dart';
import 'package:twitter/main_view/main_view.dart';
import 'package:twitter/profile_creation/bloc/bloc.dart';
import 'package:twitter/widgets/twitter_button/twitter_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  Map<String, dynamic> _formData;

  ProfileView(Map<String, dynamic> formData) {
    this._formData = formData;
  }

  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();

  void changeProfileImage(
      ImageSource imageSource, ProfileBloc profileBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      profileBloc.add(
        ProfilePictureChangedEvent(image: image),
      );
    }
  }

  Map<String, dynamic> _formData;

  @override
  void initState() {
    print(widget._formData['password']);
    _formData = {
      'email': widget._formData['email'],
      'password': widget._formData['password'],
      'handle': widget._formData['handle'],
      'first_name': '',
      'last_name': '',
      // 'picture': '',
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      body: BlocProvider(
        builder: (context) => ProfileBloc(),
        child: BlocListener(
          bloc: profileBloc,
          listener: (context, state) {
            if (state is ProfileSubmitState) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainView()));
            }
          },
          child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, state) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildAppBar(),
                      _buildForm(
                          state,
                          _formKey,
                          profileBloc,
                          state is ProfilePictureChangedState
                              ? state.image
                              : null),
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

  Widget _buildAppBar() {
    return Column(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.twitter,
          color: Colors.lightBlue,
          size: 55.0,
        )
      ],
    );
  }

  Widget _buildCircleImage(File image, ProfileBloc profileBloc) {
    return Stack(
      children: <Widget>[
        image != null
            ? CircleAvatar(
                backgroundImage: FileImage(image),
                minRadius: 80,
                maxRadius: 95,
              )
            : CircleAvatar(
                minRadius: 80,
                maxRadius: 95,
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(Icons.edit),
            mini: true,
            onPressed: () {
              changeProfileImage(ImageSource.gallery, profileBloc);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildForm(ProfileState state, GlobalKey _formKey,
      ProfileBloc profileBloc, File image) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            _buildCircleImage(image, profileBloc),
            SizedBox(
              height: 20,
            ),
            _buildFirstNameField(),
            SizedBox(
              height: 15,
            ),
            _buildLastNameField(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: _buildSubmitButton(),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: TextFormField(
        // validator:
        decoration: InputDecoration(
            hintText: "First Name",
            hintStyle: TextStyle(color: Colors.lightBlue),
            labelStyle: TextStyle(color: Colors.lightBlue),
            focusColor: Colors.teal),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_nameFocusNode),
        onSaved: (String value) {
          _formData['first_name'] = value;
        },
      ),
    );
  }

  Widget _buildLastNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: TextFormField(
        // validator:
        decoration: InputDecoration(
            hintText: "Last Name",
            hintStyle: TextStyle(color: Colors.lightBlue),
            labelStyle: TextStyle(color: Colors.lightBlue),
            focusColor: Colors.teal),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_nameFocusNode),
        onSaved: (String value) {
          _formData['last_name'] = value;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return TwitterButton(
      textColor: Colors.white,
      text: "Get Started",
      fillColor: Colors.lightBlue,
      onTap: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          print(_formData.toString());
          profileBloc.add(
            ProfileSubmitPressedEvent(
              email: _formData['email'],
              password: _formData['password'],
              name: _formData['first_name'] + " " + _formData['last_name'],
              handle: _formData['handle'],
            ),
          );
        }
      },
    );
  }
}
