import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/single_user_view/single_user_view.dart';

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
            backgroundImage: NetworkImage(user.picture),
            radius: 25,
          ),
          title: Text(user.handle),
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
                        // backgroundImage: NetworkImage(user.picture),
                        radius: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Followers"),
                      ),
                      Text("Following"),
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
