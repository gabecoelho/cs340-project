import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/widgets/tweet_cell/tweet_cell.dart';
import 'bloc/twitter_list_view_event.dart';
import '../user_cell/user_cell.dart';
import 'bloc/twitter_list_view_bloc.dart';
import 'bloc/twitter_list_view_state.dart';

enum WordType { User, Hashtag, Url }

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

  GestureRecognizer onWordTap(WordType wordType, String word) {}

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

  List<TextSpan> _configureMessage(
      BuildContext context, double fontSize, Tweet tweet) {
    List<TextSpan> configuredMessage = [];
    List<String> words = tweet.message.split(RegExp('\\s+'));
    words.forEach((word) {
      TextSpan wordWidget;
      if (word.startsWith('@')) {
        wordWidget = TextSpan(
          text: '$word ',
          recognizer: onWordTap(WordType.User, word),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        );
      } else if (word.startsWith('#')) {
        wordWidget = TextSpan(
          text: '$word ',
          recognizer: onWordTap(WordType.Hashtag, word),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        );
      } else if (word.startsWith('http')) {
        wordWidget = TextSpan(
          text: '$word ',
          recognizer: onWordTap(WordType.Url, word),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        );
      } else {
        wordWidget = TextSpan(
          text: '$word ',
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        );
      }

      configuredMessage.add(wordWidget);
    });
    return configuredMessage;
  }
}
