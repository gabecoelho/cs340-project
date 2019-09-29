import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/profile/bloc/bloc.dart';
import 'package:twitter/widgets/twitter_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void changeProfileImage(
      ImageSource imageSource, ProfileBloc profileBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      profileBloc.dispatch(
        ProfilePictureChangedEvent(image: image),
      );
    }
  }

  final Map<String, dynamic> _formData = {
    'first_name': null,
    'last_name': null,
    'picture': null
  };

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      body: BlocProvider(
        builder: (context) => ProfileBloc(),
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
                    SizedBox(
                      height: 40,
                    ),
                    _buildCircleImage(
                        state is ProfilePictureChangedState
                            ? state.image
                            : null,
                        profileBloc),
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
          },
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
        // onFieldSubmitted: (_) =>
        // FocusScope.of(context).requestFocus(_passwordFocusNode),
        // onSaved: () {},
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
        // onFieldSubmitted: (_) =>
        // FocusScope.of(context).requestFocus(_passwordFocusNode),
        // onSaved: () {},
      ),
    );
  }

  Widget _buildSubmitButton() {
    return TwitterButton(
      textColor: Colors.white,
      text: "Get Started",
      fillColor: Colors.lightBlue,
      onTap: () {},
    );
  }
}
