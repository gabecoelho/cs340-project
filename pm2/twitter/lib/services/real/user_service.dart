import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:twitter/model/http_response_models/follow_result.dart';
import 'package:twitter/model/http_response_models/followers_result.dart';
import 'package:twitter/model/http_response_models/following_result.dart';
import 'package:twitter/model/http_response_models/follows_result.dart';
import 'package:twitter/model/http_response_models/picture_upload_result.dart';
import 'package:twitter/model/http_response_models/unfollow_result.dart';
import 'package:twitter/model/http_response_models/user_result.dart';
import 'package:twitter/server_proxy/server_proxy.dart';
import 'package:twitter/model/user.dart';

class UserService {
  static ServerProxy serverProxy = ServerProxy();

  CognitoUser _cognitoUser;
  CognitoUserPool _userPool = serverProxy.getUserPool();
  CognitoUserSession _session;
  CognitoCredentials credentials;

  Future<bool> init() async {
    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    return _session != null ?? _session.isValid();
  }

  void setCognitoUser() async {
    _cognitoUser = await _userPool.getCurrentUser();
  }

  Future<User> signUp(String email, String password, String name, String handle,
      String pictureUrl) async {
    final result = await serverProxy.signUp(
        email, password, name, handle, pictureUrl.toString());
    setCognitoUser();
    return result;
  }

  Future<User> signIn(String username, String password) async {
    final signInResult = await serverProxy.signIn(username, password);

    if (signInResult != null) {
      setCognitoUser();
      return signInResult;
    } else {
      return null;
    }
  }

  void signOut() {
    return serverProxy.signOut();
  }

  Future<UserResult> getUser(String handle) async {
    return await serverProxy.getUser(handle);
  }

  Future<FollowersResult> getFollowers(
      String handle, int pageSize, String lastKey) async {
    return await serverProxy.getFollowers(handle, pageSize, lastKey);
  }

  Future<FollowingResult> getFollowing(
      String handle, int pageSize, String lastKey) async {
    return await serverProxy.getFollowing(handle, pageSize, lastKey);
  }

  Future<FollowResult> follow(String follower, String followee,
      String followerName, String followeeName) async {
    return await serverProxy.follow(
        follower, followee, followerName, followeeName);
  }

  Future<UnfollowResult> unfollow(String follower, String followee) async {
    return await serverProxy.unfollow(follower, followee);
  }

  Future<FollowsResult> follows(String follower, String followee) async {
    return await serverProxy.follows(follower, followee);
  }

  Future<String> uploadPicture(
      String handle, String base64EncodedString) async {
    return await serverProxy.uploadPicture(handle, base64EncodedString);
  }

  Future<PictureUploadResult> editPicture(
      String handle, String base64EncodedString) async {
    return await serverProxy.editPicture(handle, base64EncodedString);
  }
}
