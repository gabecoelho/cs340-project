import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/new_tweet/bloc/bloc.dart';

class NewTweetView extends StatefulWidget {
  NewTweetView({Key key}) : super(key: key);

  _NewTweetViewState createState() => _NewTweetViewState();
}

class _NewTweetViewState extends State<NewTweetView> {
  final int inputLength = 300;

  void addAttachment(ImageSource imageSource, NewTweetBloc newTweetBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      newTweetBloc.dispatch(
        AttachmentAddedNewTweetEvent(image: image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newTweetBloc = BlocProvider.of<NewTweetBloc>(context);

    return Scaffold(
      extendBody: true,
      appBar: _buildNewTweetAppBar(),
      body: BlocProvider(
        builder: (context) => newTweetBloc,
        child: BlocBuilder(
          bloc: newTweetBloc,
          builder: (context, state) {
            return _buildNewTweetBody(
                inputLength,
                state is AttachmentAddedNewTweetState ? state.image : null,
                newTweetBloc);
          },
        ),
      ),
    );
  }

  Widget _buildNewTweetAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, false),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onTap: () => Navigator.pop(context, false),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTweetBody(
      int inputLengthFile, File image, NewTweetBloc newTweetBloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            _buildTextInputField(inputLength),
            _buildAttachment(image, newTweetBloc),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputField(int inputLength) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(hintText: "What's happening?"),
      maxLength: inputLength,
    );
  }

  Widget _buildAttachment(File image, NewTweetBloc newTweetBloc) {
    return InkWell(
      child: image == null
          ? Container(
              width: 500,
              height: 500,
              decoration:
                  BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
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
    );
  }
}
