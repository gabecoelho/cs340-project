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
import 'package:twitter/model/tweet.dart';
import 'package:twitter/services/real/tweet_service.dart';
import 'package:twitter/services/real/user_service.dart';

class ServiceFacade {
  final _userService = UserService();
  final _tweetService = TweetService();

  Future<UserResult> getUser(String handle) async {
    final response = await _userService.getUser(handle);
    return response;
  }

  Future<FollowersResult> getFollowers(
      String handle, int pageSize, String lastKey) async {
    final response = await _userService.getFollowers(handle, pageSize, lastKey);
    return response;
  }

  Future<FollowingResult> getFollowing(
      String handle, int pageSize, String lastKey) async {
    final response = await _userService.getFollowing(handle, pageSize, lastKey);
    return response;
  }

  Future<FollowResult> follow(String follower, String followee,
      String followerName, String followeeName) async {
    final response = await _userService.follow(
        follower, followee, followerName, followeeName);
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

  Future<String> uploadPicture(String handle, String base64EncodedImage) async {
    final response =
        await _userService.uploadPicture(handle, base64EncodedImage);
    return response;
  }

  Future<PictureUploadResult> editPicture(
      String handle, String base64EncodedImage) async {
    final response = await _userService.editPicture(handle, base64EncodedImage);
    return response;
  }

  Future<FeedResult> getFeed(
      String handle, int pageSize, String lastKey) async {
    final response = await _tweetService.getFeed(handle, pageSize, lastKey);
    return response;
  }

  Future<StoryResult> getStory(
      String handle, int pageSize, String lastKey) async {
    final response = await _tweetService.getStory(handle, pageSize, lastKey);
    return response;
  }

  Future<HashtagResult> getHashtag(
      String hashtag, int pageSize, String lastKey) async {
    final response = await _tweetService.getHashtag(hashtag, pageSize, lastKey);
    return response;
  }

  Future<PostTweetResult> postTweet(Tweet tweet) async {
    final response = await _tweetService.postTweet(tweet);
    return response;
  }
}
