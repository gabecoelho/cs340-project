import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:twitter/model/authenticated_user.dart';
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
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';

class ServerProxy {
  static const baseUrl =
      "https://yxdchtn10i.execute-api.us-west-2.amazonaws.com/development";

  static const _awsClientId = "71tt8lfid8l1h5q4118ktcqcea";
  static const _awsPoolId = "us-west-2_6carGpVMP";
  final userPool = CognitoUserPool(_awsPoolId, _awsClientId);
  CognitoUser _cognitoUser;
  final user = new User();
  final AuthenticatedUserSingleton userSingleton = AuthenticatedUserSingleton();
  RegExp regex = new RegExp(r'(?:\\.|[^"\\])*');
  RegExp hashtagRegex = new RegExp(r'([^#])+');

  Future<User> signUp(String email, String password, String name, String handle,
      String base64EncodedString) async {
    var uploadedPictureUrl = await uploadPicture(handle, base64EncodedString);

    CognitoUserPoolData data;

    final userAttributes = [
      AttributeArg(name: "name", value: name),
      AttributeArg(name: "email", value: email),
      AttributeArg(name: "preferred_username", value: handle),
      AttributeArg(name: "picture", value: uploadedPictureUrl)
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

    _cognitoUser = data.user;

    user.handle = handle;
    user.name = name;
    user.picture = uploadedPictureUrl;

    await registerUser(handle, name, uploadedPictureUrl);

    return user;
  }

  Future<User> signIn(String handle, String password) async {
    _cognitoUser = CognitoUser(handle, userPool);

    final authDetails = AuthenticationDetails(
      username: handle,
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
    final user = User.fromUserAttributes(attributes);

    userSingleton.authenticatedUser.user = user;
    return user;
  }

  void signOut() async {
    await _cognitoUser.signOut();
  }

  Future<UserResult> getUser(String handle) async {
    final response = await http.get("$baseUrl/user/$handle");
    return userResultFromJson(response.body);
  }

  Future<HashtagResult> getHashtag(
      String hashtag, int pageSize, String lastKey) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    hashtag = hashtagRegex.stringMatch(hashtag);

    final String reqUrl =
        "$baseUrl/status/hashtag/$hashtag?pageSize=$pageSize&lastKey=$lastKey";
    print(reqUrl);
    final response = await http.get(reqUrl, headers: headers);
    print(response.body);
    return hashtagResultFromJson(response.body);
  }

  Future<FeedResult> getFeed(
      String handle, int pageSize, String lastKey) async {
    final response = await http
        .get("$baseUrl/user/$handle/feed?pageSize=$pageSize&lastKey=$lastKey");
    print(response.body);
    return feedResultFromJson(response.body);
  }

  Future<StoryResult> getStory(
      String handle, int pageSize, String lastKey) async {
    final response = await http
        .get("$baseUrl/user/$handle/story?pageSize=$pageSize&lastKey=$lastKey");
    print(response.body);
    return storyResultFromJson(response.body);
  }

  Future<FollowersResult> getFollowers(
      String handle, int pageSize, String lastKey) async {
    final response = await http.get(
        "$baseUrl/user/$handle/followers?pageSize=$pageSize&lastKey=$lastKey");
    print(response.body);
    return followersResultFromJson(response.body);
  }

  Future<FollowingResult> getFollowing(
      String handle, int pageSize, String lastKey) async {
    final response = await http.get(
        "$baseUrl/user/$handle/following?pageSize=$pageSize&lastKey=$lastKey");
    print(response.body);
    return followingResultFromJson(response.body);
  }

  Future<FollowResult> follow(String followerHandle, String followeeHandle,
      String followerName, String followeeName) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final reqBody =
        '{ "follower_name": "$followerName", "followee_name": "$followeeName" }';
    final response = await http.post(
        "$baseUrl/user/$followerHandle/follow/$followeeHandle",
        headers: headers,
        body: reqBody);
    print(response.body);
    return followResultFromJson(response.body);
  }

  Future<UnfollowResult> unfollow(String follower, String followee) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final reqBody =
        '{"follower_handle": "$follower", "followee_handle": "$followee"}';

    final response = await http.post(
        "$baseUrl/user/$follower/unfollow/$followee",
        headers: headers,
        body: reqBody);

    print(response.body);
    return unfollowResultFromJson(response.body);
  }

  Future<FollowsResult> follows(String follower, String followee) async {
    final response =
        await http.get("$baseUrl/user/$follower/follows/$followee");
    print(response.body);
    return followsResultFromJson(response.body);
  }

  Future<PostTweetResult> postTweet(Tweet tweet) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    print("tweet.attachment is equal to:" + tweet.attachment);

    if (tweet.attachment != "null") {
      print("got here");
      tweet.attachment =
          await uploadPicture(tweet.handle + tweet.timestamp, tweet.attachment);
    } else {
      tweet.attachment = "\"null\"";
    }

    final handle = tweet.handle;
    final name = tweet.name;
    final photo = tweet.picture;
    final message = tweet.message;
    final attachment = tweet.attachment;
    final timestamp = tweet.timestamp;

    final reqBody =
        '{"tweetDTO": { "userHandle": "$handle", "userName": "$name", "userPhoto": $photo, "message": "$message", "attachment": $attachment, "timestamp": "$timestamp" }}';

    print(reqBody);
    final response = await http.post("$baseUrl/status/post",
        headers: headers, body: reqBody);

    print(response.body);
    return postTweetResultFromJson(response.body);
  }

  Future<String> uploadPicture(
      String handle, String base64EncodedString) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final reqBody = '{"base64EncodedString": $base64EncodedString}';

    final response = await http.post("$baseUrl/user/$handle/upload/picture",
        headers: headers, body: reqBody);

    return (response.body);
  }

  Future<dynamic> registerUser(
      String handle, String userName, String photoUrl) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    String reqBody =
        '{"userDTO": { "userHandle": "$handle", "userName": "$userName", "userPicture": $photoUrl} }';

    print("reqbody from registeruser: " + reqBody);

    final response =
        await http.post("$baseUrl/signup", headers: headers, body: reqBody);

    print("result from registeruser: " + response.body);
    return response.body;
  }

  CognitoUserPool getUserPool() {
    return userPool;
  }
}
