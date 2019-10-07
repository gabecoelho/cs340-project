import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_followers_strategy.dart';
import 'package:twitter/services/strategy/fetch_following_strategy.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/user_follow_view/user_follow_view.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class UserProfileView extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;
  final User user;

  UserProfileView.empty(this.fetchListStrategy, this.user);

  UserProfileView({this.fetchListStrategy, this.user}) : super();

  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserProfile(widget.user),
    );
  }

  Widget _buildUserProfile(User user) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: FileImage(user.picture),
            radius: 80,
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${user.followers.length} Followers"),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                      fetchListStrategy: FetchFollowersStrategy()),
                ),
              );
            },
          ),
          InkWell(
            child: Text("${user.following.length} Following"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                      fetchListStrategy: FetchFollowingStrategy()),
                ),
              );
            },
          ),
          Divider(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TwitterListView<Tweet>(
                fetchListStrategy: FetchStoryStrategy(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
