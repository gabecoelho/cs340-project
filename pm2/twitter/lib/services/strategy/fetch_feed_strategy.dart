import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/mock/mock_tweet_list.dart';

class FetchFeedStrategy implements FetchListStrategy {
  @override
  Future fetchList() async {
    //call mock service...
    //return tweet?
    MockTweetList mockTweetList = MockTweetList();

    return await mockTweetList.getFeed();
  }
}
