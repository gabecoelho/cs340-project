import 'package:twitter/model/http_response_models/feed_result.dart';
import 'package:twitter/model/http_response_models/hashtag_result.dart';
import 'package:twitter/model/http_response_models/post_tweet_result.dart';
import 'package:twitter/model/http_response_models/story_result.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/server_proxy/server_proxy.dart';

class TweetService {
  ServerProxy serverProxy = ServerProxy();

  Future<StoryResult> getStory(
      String handle, int pageSize, String lastKey) async {
    return await serverProxy.getStory(handle, pageSize, lastKey);
  }

  Future<FeedResult> getFeed(
      String handle, int pageSize, String lastKey) async {
    return await serverProxy.getFeed(handle, pageSize, lastKey);
  }

  Future<HashtagResult> getHashtag(
      String hashtag, int pageSize, String lastKey) async {
    return await serverProxy.getHashtag(hashtag, pageSize, lastKey);
  }

  Future<PostTweetResult> postTweet(Tweet tweet) async {
    return await serverProxy.postTweet(tweet);
  }
}
