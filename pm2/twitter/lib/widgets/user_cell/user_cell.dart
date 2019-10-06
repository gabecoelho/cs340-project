import 'dart:io';
import 'package:flutter/material.dart';

class UserCell extends StatelessWidget {
  final String name;
  final String handle;
  final File image;

  UserCell({
    Key key,
    this.name,
    this.handle,
    this.image,
  }) : super(key: key);

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
          title: Text(name),
          subtitle: Text(handle),
        ),
        Divider()
      ],
    );
  }
}
