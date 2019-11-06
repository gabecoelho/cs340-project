import 'package:twitter/model/http_response_models/feed_result.dart';
import 'package:twitter/model/http_response_models/follow_result.dart';
import 'package:twitter/model/http_response_models/followers_result.dart';
import 'package:twitter/model/http_response_models/following_result.dart';
import 'package:twitter/model/http_response_models/follows_result.dart';
import 'package:twitter/model/http_response_models/hashtag_result.dart';
import 'package:twitter/model/http_response_models/picture_upload_result.dart';
import 'package:twitter/model/http_response_models/post_tweet_result.dart';
import 'package:twitter/model/http_response_models/story_result.dart';
import 'package:twitter/model/http_response_models/unfollow_result.dart';
import 'package:twitter/model/http_response_models/user_result.dart';
import 'package:twitter/services/real/tweet_service.dart';
import 'package:twitter/services/real/user_service.dart';

class ServiceFacade {
  final _userService = UserService();
  final _tweetService = TweetService();

  Future<UserResult> getUser(String username) async {
    final response = await _userService.getUser(username);
    return response;
  }

  Future<FollowersResult> getFollowers(String username) async {
    final response = await _userService.getFollowers(username);
    return response;
  }

  Future<FollowingResult> getFollowing(String username) async {
    final response = await _userService.getFollowing(username);
    return response;
  }

  Future<FollowResult> follow(String follower, String followee) async {
    final response = await _userService.follow(follower, followee);
    return response;
  }

  Future<UnfollowResult> unfollow(String follower, String followee) async {
    final response = await _userService.unfollow(follower, followee);
    return response;
  }

  Future<FollowsResult> follows(String follower, String followee) async {
    final response = await _userService.follows(follower, followee);
    return response;
  }

  Future<PictureUploadResult> uploadPicture(String username) async {
    final response = await _userService.uploadPicture(username);
    return response;
  }

  Future<FeedResult> getFeed(String username) async {
    final response = await _tweetService.getFeed(username);
    return response;
  }

  Future<StoryResult> getStory(String username) async {
    final response = await _tweetService.getStory(username);
    return response;
  }

  Future<HashtagResult> getHashtag(String hashtag) async {
    final response = await _tweetService.getHashtag(hashtag);
    return response;
  }

  Future<PostTweetResult> postTweet() async {
    final response = await _tweetService.postTweet();
    return response;
  }
}
