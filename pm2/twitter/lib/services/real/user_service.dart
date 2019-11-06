import 'package:twitter/model/http_response_models/follow_result.dart';
import 'package:twitter/model/http_response_models/followers_result.dart';
import 'package:twitter/model/http_response_models/following_result.dart';
import 'package:twitter/model/http_response_models/follows_result.dart';
import 'package:twitter/model/http_response_models/picture_upload_result.dart';
import 'package:twitter/model/http_response_models/unfollow_result.dart';
import 'package:twitter/model/http_response_models/user_result.dart';
import 'package:twitter/server_proxy/server_proxy.dart';

class UserService {
  ServerProxy serverProxy = ServerProxy();

  Future<UserResult> getUser(String username) async {
    return await serverProxy.getUser(username);
  }

  Future<FollowersResult> getFollowers(String username) async {
    return await serverProxy.getFollowers(username);
  }

  Future<FollowingResult> getFollowing(String username) async {
    return await serverProxy.getFollowing(username);
  }

  Future<FollowResult> follow(String follower, String followee) async {
    return await serverProxy.follow(follower, followee);
  }

  Future<UnfollowResult> unfollow(String follower, String followee) async {
    return await serverProxy.unfollow(follower, followee);
  }

  Future<FollowsResult> follows(String follower, String followee) async {
    return await serverProxy.follows(follower, followee);
  }

  Future<PictureUploadResult> uploadPicture(String username) async {
    return await serverProxy.uploadPicture(username);
  }
}
