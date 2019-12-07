//any other user
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';

class AuthenticatedUser {
  User user = User();
  List<Tweet> feed = [];
  List<Tweet> story = [];
  List<User> followers = [];
  List<User> following = [];
  List<Tweet> hashtags = [];
}

//Authenticated User Singleton
class AuthenticatedUserSingleton {
  AuthenticatedUser authenticatedUser;

  static final AuthenticatedUserSingleton _instance =
      AuthenticatedUserSingleton._internal();

  factory AuthenticatedUserSingleton() {
    return _instance;
  }

  AuthenticatedUserSingleton._internal() {
    authenticatedUser = AuthenticatedUser();
  }
}
