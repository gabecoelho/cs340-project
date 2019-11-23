import 'dart:async';
import 'package:http/http.dart' as http;
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
import 'package:amazon_cognito_identity_dart/cognito.dart';

class ServerProxy {
  static const baseUrl =
      "https://yxdchtn10i.execute-api.us-west-2.amazonaws.com/development";
  static const _awsClientId = "71tt8lfid8l1h5q4118ktcqcea";
  static const _awsPoolId = "us-west-2_6carGpVMP";
  final userPool = new CognitoUserPool(_awsPoolId, _awsClientId);

  Future<CognitoUserPoolData> signUp(
      String email, String password, String name, String handle) async {
    CognitoUserPoolData data;

    final userAttributes = [
      new AttributeArg(name: "name", value: name),
      new AttributeArg(name: "email", value: email),
      new AttributeArg(name: "preferred_username", value: handle),
      new AttributeArg(
          name: 'picture',
          value:
              "https://www.google.com/url?sa=i&source=images&cd=&ved=2ahUKEwiMnuTK8vnlAhXUCTQIHaaHA3MQjRx6BAgBEAQ&url=https%3A%2F%2Fwinjennster.tumblr.com%2Fpost%2F182202297119%2Fanimoji-team-free-will-on-my-phone-cas-is-so%3Fis_related_post%3D1&psig=AOvVaw1yY08vxaLlQFMyZlPc5CoK&ust=1574377280734685")
    ];

    try {
      data = await userPool.signUp(email, password,
          userAttributes: userAttributes);
    } catch (e) {
      print(e);
    }

    if (data != null) {
      data.userConfirmed = true;
    }
    print(data.userConfirmed);
    return data;
  }

  Future<dynamic> signIn(String username, String password) async {
    final _cognitoUser = new CognitoUser(username, userPool);

    final authDetails = new AuthenticationDetails(
      username: username,
      password: password,
    );

    CognitoUserSession _session;

    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
    } catch (e) {
      print(e);
    }

    if (_session == null) {
      return null;
    }

    final attributes = await _cognitoUser.getUserAttributes();
    return attributes;
  }

  void signOut(CognitoUser cognitoUser) {
    cognitoUser.signOut();
  }

  Future<UserResult> getUser(String username) async {
    final response = await http.get("$baseUrl/user/$username");
    return userResultFromJson(response.body);
  }

  //TODO: Pagination
  Future<HashtagResult> getHashtag(String hashtag) async {
    // final response = await http
    //     .get("$baseUrl/status/$hashtag?lastkey=$lastkey&pagesize=$pagesize");
    final response = await http.get("$baseUrl/status/hashtag/$hashtag");
    return hashtagResultFromJson(response.body);
  }

  //TODO: Pagination
  Future<FeedResult> getFeed(String username) async {
    final response = await http.get("$baseUrl/user/$username/feed");
    return feedResultFromJson(response.body);
  }

  //TODO: Pagination
  Future<StoryResult> getStory(String username) async {
    final response = await http.get("$baseUrl/user/$username/story");
    return storyResultFromJson(response.body);
  }

  //TODO: Pagination
  Future<FollowersResult> getFollowers(String username) async {
    final response = await http.get("$baseUrl/user/$username/followers");
    return followersResultFromJson(response.body);
  }

  //TODO: Pagination
  Future<FollowingResult> getFollowing(String username) async {
    final response = await http.get("$baseUrl/user/$username/following");
    return followingResultFromJson(response.body);
  }

  Future<FollowResult> follow(String follower, String followee) async {
    final response =
        await http.post("$baseUrl/user/$follower/follow/$followee");
    print(response.body);
    return followResultFromJson(response.body);
  }

  Future<UnfollowResult> unfollow(String follower, String followee) async {
    final response =
        await http.post("$baseUrl/user/$follower/unfollow/$followee");
    print(response.body);
    return unfollowResultFromJson(response.body);
  }

  Future<FollowsResult> follows(String follower, String followee) async {
    final response =
        await http.post("$baseUrl/user/$follower/follows/$followee");
    print(response.body);
    return followsResultFromJson(response.body);
  }

  //TODO: Implement POST request === postTweet(PostTweetRequest requestBody)
  Future<PostTweetResult> postTweet() async {
    final response = await http.post(
      "$baseUrl/status/post",
      // headers: {
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //     HttpHeaders.authorizationHeader : ''
      //   },
      //   body: postTweetResultToJson(PostTweetRequest requestBody)
    );
    print(response.body);
    return postTweetResultFromJson(response.body);
  }

  //TODO: Implement POST request
  Future<PictureUploadResult> uploadPicture(String username) async {
    final response = await http.patch("$baseUrl/user/$username/edit/picture");
    print(response.body);
    return pictureUploadResultFromJson(response.body);
  }
}
