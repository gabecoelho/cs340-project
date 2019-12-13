import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/main_view/main_view.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:intl/intl.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/new_tweet/bloc/bloc.dart';

class NewTweetView extends StatefulWidget {
  _NewTweetViewState createState() => _NewTweetViewState();
}

class _NewTweetViewState extends State<NewTweetView> {
  final int inputLength = 300;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _messageFocusNode = FocusNode();
  var formatter = new DateFormat("yyyyMMdd'T'HHmmss'Z'");

  Map<String, dynamic> _formData;
  AuthenticatedUserSingleton userSingleton = AuthenticatedUserSingleton();

  @override
  void initState() {
    _formData = {
      'message': '',
      'attachment': 'null',
    };
    super.initState();
  }

  void addAttachment(ImageSource imageSource, NewTweetBloc newTweetBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      newTweetBloc.add(
        AttachmentAddedNewTweetEvent(image: image),
      );
    }

    if (image != null) {
      List<int> imageBytes = image.readAsBytesSync();
      _formData['attachment'] = base64Encode(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final newTweetBloc = BlocProvider.of<NewTweetBloc>(context);

    return Container(
        child: BlocProvider(
      builder: (context) => newTweetBloc,
      child: BlocBuilder(
        bloc: newTweetBloc,
        builder: (context, state) {
          return Scaffold(
              key: _scaffoldKey,
              extendBody: true,
              appBar: _buildNewTweetAppBar(newTweetBloc, state),
              body: _buildForm(state, _formKey, newTweetBloc,
                  state is AttachmentAddedNewTweetState ? state.image : null));
        },
      ),
    ));
  }

  Widget _buildForm(NewTweetState state, GlobalKey _formKey,
      NewTweetBloc newTweetBloc, File image) {
    return Form(
      key: _formKey,
      child: Center(
        child: Stack(
          children: <Widget>[
            _buildTextInputField(inputLength),
            _buildAttachment(image, newTweetBloc),
          ],
        ),
      ),
    );
  }

  Widget _buildNewTweetAppBar(NewTweetBloc newTweetBloc, NewTweetState state) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        // onPressed: () => Navigator.pop(context, true),
        onPressed: () {
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => MainView()));
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onTap: () async {
              print(state.toString());
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print(_formData['attachment']);
                newTweetBloc.add(SendNewTweetEvent(
                    tweet: Tweet(
                        handle: userSingleton.authenticatedUser.user.handle,
                        name: userSingleton.authenticatedUser.user.name,
                        picture: userSingleton.authenticatedUser.user.picture,
                        message: _formData['message'].toString(),
                        attachment: _formData['attachment'],
                        timestamp: formatter.format(DateTime.now()))));
              }
              if (state is TweetSentNewTweetState) {
                _showSnackBar(context, "Tweet Sent");
              }
              _formKey.currentState.reset();
              _formData.clear();
              // Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextInputField(int inputLength) {
    return SingleChildScrollView(
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 300,
        decoration: InputDecoration(hintText: "What's happening?"),
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_messageFocusNode),
        onSaved: (String value) {
          _formData['message'] = value;
        },
        maxLength: inputLength,
      ),
    );
  }

  Widget _buildAttachment(File image, NewTweetBloc newTweetBloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: InkWell(
        child: image == null
            ? Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.grey),
                child: Icon(Icons.attach_file),
              )
            : Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(image))),
              ),
        onTap: () {
          addAttachment(ImageSource.gallery, newTweetBloc);
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Dismiss',
            onPressed: _scaffoldKey.currentState.hideCurrentSnackBar),
      ),
    );
  }
}
