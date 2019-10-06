import 'dart:io';

import 'package:twitter/model/tweet.dart';

class MockTweetList {
  // Future getAllTweets(User user) {
  //   // call 3rd party API to get a list of tweets from a user
  // }

  List<Tweet> getFeed() {
    // call 3rd party API to get a list of tweets from a user
    Tweet hashtagTweet = Tweet(
        "John Doe",
        "@johndoe",
        "This is a message with a #hashtag",
        "Oct 4",
        File(
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
        ));

    Tweet aliasTweet = Tweet(
        "Mike Shinoda",
        "@mikeshinoda",
        "saying hello to @johndoe",
        "Oct 3",
        File(
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/2_placeholder.png',
        ));

    Tweet attachmentTweet = Tweet(
      "Ed Sheeran",
      "@eddy",
      "an attachment",
      "Oct 3",
      File(
        '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/3_placeholder.png',
      ),
      attachment: File(
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/real_twitter.png'),
    );

    List<Tweet> list = List();
    list.add(hashtagTweet);
    list.add(aliasTweet);
    list.add(attachmentTweet);

    return list;
  }

  List<Tweet> getStory() {
    Tweet mySecondTweet = Tweet(
        "John Doe",
        "@johndoe",
        "This is my second tweet",
        "Oct 4",
        File(
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
        ));

    Tweet myFirstTweet = Tweet(
        "John Doe",
        "@johndoe",
        "This is my first tweet",
        "Oct 3",
        File(
          '/Users/palmacoe/byu/cs340/cs340-project/pm2/twitter/lib/assets/placeholder.png',
        ));

    List<Tweet> list = List();
    list.add(mySecondTweet);
    list.add(myFirstTweet);

    return list;
  }
}
