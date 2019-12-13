import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter/model/tweet.dart';

class MockTweetList {
  // Future getAllTweets(User user) {
  //   // call 3rd party API to get a list of tweets from a user
  // }

  List<Tweet> getFeed() {
    // call 3rd party API to get a list of tweets from a user
    Tweet hashtagTweet = Tweet(
      handle: "@johndoe",
      message: "This is a message with a #hashtag",
      timestamp: DateTime.now().toIso8601String(),
      picture:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
    );

    Tweet aliasTweet = Tweet(
      handle: "@mikeshinoda",
      message: "saying hello to @johndoe",
      timestamp: DateTime.now().toIso8601String(),
      picture:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/2_placeholder.png',
    );

    Tweet attachmentTweet = Tweet(
      handle: "@eddy",
      message: "an attachment",
      timestamp: DateTime.now().toIso8601String(),
      picture:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/3_placeholder.png',
      attachment:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/real_twitter.png',
    );

    List<Tweet> list = List();
    list.add(hashtagTweet);
    list.add(aliasTweet);
    list.add(attachmentTweet);

    return list;
  }

  List<Tweet> getStory() {
    Tweet mySecondTweet = Tweet(
      handle: "@johndoe",
      message: "This is my second tweet",
      timestamp: DateTime.now().toIso8601String(),
      picture:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
    );

    Tweet myFirstTweet = Tweet(
      handle: "@johndoe",
      message: "This is my first tweet",
      timestamp: DateTime.now().toIso8601String(),
      picture:
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
    );

    List<Tweet> list = List();
    list.add(mySecondTweet);
    list.add(myFirstTweet);

    return list;
  }
}
