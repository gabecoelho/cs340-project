import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter/single_tweet_view/single_tweet_view.dart';

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

  UniqueKey uniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return listBuilder(context, uniqueKey);
  }

  Column listBuilder(BuildContext context, UniqueKey uniqueKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          key: uniqueKey,
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: FileImage(image),
            radius: 25,
          ),
          title: Text(username),
          subtitle: Text(handle),
          trailing: Text(timestamp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleTweetView(
                  column: Column(
                    children: <Widget>[
                      ListTile(
                        key: uniqueKey,
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
                  ),
                ),
              ),
            );
          },
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
