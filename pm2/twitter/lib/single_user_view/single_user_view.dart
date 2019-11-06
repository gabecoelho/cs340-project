import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/profile_creation/bloc/profile_creation_bloc.dart';
import 'package:twitter/profile_creation/bloc/profile_creation_event.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/user_profile/user_profile_view.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class SingleUserView extends StatefulWidget {
  final Column column;
  final User user;

  SingleUserView({Key key, @required this.column, @required this.user})
      : super(key: key);

  @override
  _SingleUserViewState createState() => _SingleUserViewState();
}

class _SingleUserViewState extends State<SingleUserView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: _buildNewUserViewAppBar(context),
        body: Stack(
          children: <Widget>[
            _buildUpperPiece(context),
            _buildFollowButton(),
          ],
        ));
  }

  Widget _buildNewUserViewAppBar(BuildContext context) {
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

  Widget _buildUpperPiece(BuildContext context) {
    return Stack(children: <Widget>[
      UserProfileView(
        user: this.widget.user,
        isOtherUser: true,
      ),
    ]);
  }

  Widget _buildFollowButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          child: Text(
            "Follow",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          color: Colors.lightBlue,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
        ),
      ],
    );
  }
}
