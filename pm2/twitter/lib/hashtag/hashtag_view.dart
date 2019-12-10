import 'package:flutter/material.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/services/strategy/fetch_hashtag_strategy.dart';
import 'package:twitter/widgets/twitter_list_view/bloc/twitter_list_view_state.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class HashtagView extends StatefulWidget {
  List<Tweet> hashtags;

  HashtagView({@required this.hashtags});

  @override
  _HashtagViewState createState() => _HashtagViewState();
}

class _HashtagViewState extends State<HashtagView> {
  AuthenticatedUserSingleton userModelSingleton = AuthenticatedUserSingleton();
  TwitterListViewState twitterListViewState;

  @override
  void initState() {
    twitterListViewState = TwitterListViewHashtagTappedState(widget.hashtags);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNewTweetAppBar(context),
      body: Container(
        child: TwitterListView<Tweet>(
          fetchListStrategy: FetchHashtagStrategy(),
          user: userModelSingleton.authenticatedUser.user,
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
