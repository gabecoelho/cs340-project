//any other user
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';

class UserModel {
  User user = User();
  List<Tweet> feed = [];
  List<Tweet> story = [];
  List<Tweet> hashtags = [];
  List<User> followers = [];
  List<User> following = [];
  String feedLastKey = "";
  String storyLastKey = "";
  String followersLastKey = "";
  String followingLastKey = "";
  String hashtagsLastKey = "";
}

//Authenticated User Singleton
class AuthenticatedUserSingleton {
  UserModel authenticatedUser;

  static final AuthenticatedUserSingleton _instance =
      AuthenticatedUserSingleton._internal();

  factory AuthenticatedUserSingleton() {
    return _instance;
  }

  AuthenticatedUserSingleton._internal() {
    authenticatedUser = UserModel();
  }
}
