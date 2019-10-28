import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/single_tweet_view/single_tweet_view.dart';
import 'package:twitter/single_user_view/single_user_view.dart';
import 'package:twitter/widgets/tweet_cell/tweet_cell.dart';
import 'bloc/twitter_list_view_event.dart';
import '../user_cell/user_cell.dart';
import 'bloc/twitter_list_view_bloc.dart';
import 'bloc/twitter_list_view_state.dart';

abstract class TweetInterface {
  void userTapped(String handle);
  void hashtagTapped(String hashtag);
}

class TwitterListView<T> extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;

  const TwitterListView({
    Key key,
    this.fetchListStrategy,
  }) : super(key: key);

  @override
  _TwitterListViewState<T> createState() => _TwitterListViewState<T>();
}

class _TwitterListViewState<T> extends State<TwitterListView<T>>
    implements TweetInterface {
  TwitterListViewBloc _bloc;

  @override
  void initState() {
    _bloc = TwitterListViewBloc<T>(widget.fetchListStrategy);
    _bloc.add(TwitterListViewFetchListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is TwitterListViewLoadedState) {
            return Container(
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, i) {
                  if (T == Tweet) {
                    final tweet = state.list[i];
                    return TweetCell(
                      username: tweet.username,
                      handle: tweet.handle,
                      message: tweet.message,
                      timestamp: tweet.timestamp,
                      image: tweet.image,
                      attachment: tweet.attachment,
                      tweetInterface: this,
                    );
                  } else {
                    final user = state.list[i];
                    return UserCell(
                      user: user,
                    );
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void hashtagTapped(String hashtag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleTweetView(
          column: Column(
            children: <Widget>[
              TweetCell(
                username: "whatevs",
                handle: "@whatevs",
                message: "This is a message with a #hashtag",
                timestamp: "Oct 7",
                image: File(
                    "/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png"),
                tweetInterface: this,
                attachment: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void userTapped(String handle) {
    User user = User(
        "John Doe",
        "@johndoe",
        "jd@jd.com",
        File(
            "/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png"),
        [],
        []);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleUserView(
          user: user,
          column: Column(),
        ),
      ),
    );
  }
}
