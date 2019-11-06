import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter/single_tweet_view/single_tweet_view.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

enum WordType { User, Hashtag }

class TweetCell extends StatefulWidget {
  final String handle;
  final String message;
  final String timestamp;
  final String picture;
  final String attachment;
  final TweetInterface tweetInterface;

  TweetCell(
      {Key key,
      this.handle,
      this.message,
      this.timestamp,
      this.picture,
      this.attachment,
      this.tweetInterface})
      : super(key: key);

  @override
  _TweetCellState createState() => _TweetCellState();
}

class _TweetCellState extends State<TweetCell> {
  final UniqueKey uniqueKey = UniqueKey();

  GestureRecognizer onWordTap(WordType wordType, String keyWord) {
    return TapGestureRecognizer()
      ..onTap = () {
        switch (wordType) {
          case WordType.User:
            widget.tweetInterface?.userTapped(keyWord);
            break;
          case WordType.Hashtag:
            widget.tweetInterface?.hashtagTapped(keyWord);
        }
      };
  }

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
            backgroundImage: NetworkImage(widget.picture),
            radius: 25,
          ),
          title: Text(widget.handle),
          subtitle: Text(widget.handle),
          trailing: Text(widget.timestamp),
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
                          backgroundImage: NetworkImage(widget.picture),
                          radius: 25,
                        ),
                        title: Text(widget.handle),
                        subtitle: Text(widget.handle),
                        trailing: Text(widget.timestamp),
                      ),
                      Container(
                        child: Text(widget.message.toString()),
                      ),
                      widget.attachment == null
                          ? Container()
                          : Image.network(widget.attachment),
                      Divider()
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        RichText(
          text: TextSpan(
            children: _configureMessage(context, 16),
          ),
        ),
        widget.attachment == null
            ? Container()
            : Image.network(widget.attachment),
        Divider()
      ],
    );
  }

  List<TextSpan> _configureMessage(
    BuildContext context,
    double fontSize,
  ) {
    List<TextSpan> configuredMessage = [];
    List<String> words = widget.message.split(RegExp('\\s+'));
    words.forEach((word) {
      TextSpan wordWidget;
      if (word.startsWith('@')) {
        wordWidget = TextSpan(
          text: '$word ',
          recognizer: onWordTap(WordType.User, word),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        );
      } else if (word.startsWith('#')) {
        wordWidget = TextSpan(
          text: '$word ',
          recognizer: onWordTap(WordType.Hashtag, word),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        );
      } else {
        wordWidget = TextSpan(
          text: '$word ',
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        );
      }

      configuredMessage.add(wordWidget);
    });
    return configuredMessage;
  }
}
