import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/single_user_view/single_user_view.dart';
import 'package:twitter/user_profile/user_profile_view.dart';

class UserCell extends StatelessWidget {
  final User user;

  UserCell({this.user}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: FileImage(user.picture),
            radius: 25,
          ),
          title: Text(user.name),
          subtitle: Text(user.handle),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleUserView(
                  user: user,
                  column: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: FileImage(user.picture),
                        radius: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${user.followers.length} Followers"),
                      ),
                      Text("${user.following.length} Following"),
                      Divider(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Divider()
      ],
    );
  }
}
