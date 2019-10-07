import 'package:flutter/material.dart';
import 'package:twitter/widgets/tweet_cell/tweet_cell.dart';

class SingleTweetView extends StatelessWidget {
  final Column column;

  SingleTweetView({Key key, @required this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: this.column,
      ),
    );
  }
}
