import 'package:twitter/model/http_response_models/feed_result.dart';
import 'package:twitter/model/http_response_models/hashtag_result.dart';
import 'package:twitter/model/http_response_models/post_tweet_result.dart';
import 'package:twitter/model/http_response_models/story_result.dart';
import 'package:twitter/server_proxy/server_proxy.dart';

class TweetService {
  ServerProxy serverProxy = ServerProxy();

  Future<StoryResult> getStory(String username) async {
    return await serverProxy.getStory(username);
  }

  Future<FeedResult> getFeed(String username) async {
    return await serverProxy.getFeed(username);
  }

  Future<HashtagResult> getHashtag(String hashtag) async {
    return await serverProxy.getHashtag(hashtag);
  }

  Future<PostTweetResult> postTweet() async {
    return await serverProxy.postTweet();
  }
}
