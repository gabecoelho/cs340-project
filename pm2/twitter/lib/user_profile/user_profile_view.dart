import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class UserProfileView extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;

  UserProfileView({Key key, this.fetchListStrategy}) : super(key: key);

  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  static List<User> followers = List();
  static List<User> following = List();

  User user = User(
      "John Doe",
      "@johndoe",
      "johndoe@email.com",
      File(
          "/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png"),
      followers,
      following);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserProfile(),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
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
