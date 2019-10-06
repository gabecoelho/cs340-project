import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TweetCell extends StatelessWidget {
  final String username;
  final String handle;
  final String message;
  final String timestamp;
  final File image;
  File attachment;

  TweetCell(
      {Key key,
      this.username,
      this.handle,
      this.message,
      this.timestamp,
      this.image,
      this.attachment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: FileImage(image),
            radius: 25,
          ),
          title: Text(username),
          subtitle: Text(handle),
          trailing: Text(timestamp),
        ),
        Container(
          child: Text(message),
        ),
        attachment == null ? Container() : Image.file(attachment),
        Divider()
      ],
    );
  }
}
