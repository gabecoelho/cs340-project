import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_followers_strategy.dart';
import 'package:twitter/services/strategy/fetch_following_strategy.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class UserFollowView extends StatelessWidget {
  final FetchListStrategy fetchListStrategy;
  User user;

  UserFollowView({this.fetchListStrategy, this.user}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: fetchListStrategy is FetchFollowingStrategy
              ? TwitterListView<User>(
                  fetchListStrategy: FetchFollowingStrategy(),
                  user: user,
                )
              : TwitterListView<User>(
                  fetchListStrategy: FetchFollowersStrategy(),
                  user: user,
                ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
