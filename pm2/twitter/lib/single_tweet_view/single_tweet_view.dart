import 'package:flutter/material.dart';

class SingleTweetView extends StatelessWidget {
  final Column column;

  SingleTweetView({Key key, @required this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNewTweetAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: this.column,
      ),
    );
  }

  Widget _buildNewTweetAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }
}
