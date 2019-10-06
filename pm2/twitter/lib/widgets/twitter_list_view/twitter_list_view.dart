import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/widgets/tweet_cell/tweet_cell.dart';
import 'package:twitter/widgets/twitter_list_view/bloc/twitter_list_view_event.dart';
import 'package:twitter/widgets/user_cell/user_cell.dart';

import 'bloc/twitter_list_view_bloc.dart';
import 'bloc/twitter_list_view_state.dart';

class TwitterListView<T> extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;

  const TwitterListView({
    Key key,
    this.fetchListStrategy,
  }) : super(key: key);

  @override
  _TwitterListViewState<T> createState() => _TwitterListViewState<T>();
}

class _TwitterListViewState<T> extends State<TwitterListView<T>> {
  TwitterListViewBloc _bloc;

  @override
  void initState() {
    _bloc = TwitterListViewBloc<T>(widget.fetchListStrategy);
    _bloc.dispatch(TwitterListViewFetchListEvent());
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
                    );
                  } else {
                    final user = state.list[i];
                    return UserCell(
                      name: user.name,
                      handle: user.handle,
                      image: user.picture,
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
}
