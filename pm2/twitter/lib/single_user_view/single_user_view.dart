import 'package:flutter/material.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/user_profile/user_profile_view.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class SingleUserView extends StatelessWidget {
  final Column column;
  final User user;

  SingleUserView({Key key, @required this.column, @required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: _buildNewUserViewAppBar(context),
        body: _buildUpperPiece());
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

  Widget _buildUpperPiece() {
    return UserProfileView(
      user: this.user,
    );
  }

  Widget _buildBottomPiece() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: TwitterListView<Tweet>(
          fetchListStrategy: FetchStoryStrategy(),
        ),
      ),
    );
  }

  Widget _buildSingleUserView() {
    return Stack(
      children: <Widget>[
        _buildUpperPiece(),
        _buildBottomPiece(),
      ],
    );
  }
}
