import 'package:flutter/material.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/services/strategy/fetch_hashtag_strategy.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class HashtagView extends StatefulWidget {
  HashtagView({Key key}) : super(key: key);

  @override
  _HashtagViewState createState() => _HashtagViewState();
}

class _HashtagViewState extends State<HashtagView> {
  UserModelSingleton userModelSingleton = UserModelSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNewTweetAppBar(context),
      body: Container(
        child: TwitterListView<Tweet>(
          fetchListStrategy: FetchHashtagStrategy(),
          authenticatedUser: userModelSingleton.userModel,
        ),
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
