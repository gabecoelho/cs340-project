//any other user
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';

class AuthenticatedUser {
  User user = User(
      name: "Test",
      handle: "@test",
      picture:
          "https://www.brownweinraub.com/wp-content/uploads/2017/09/placeholder.jpg");
  List<Tweet> feed = [];
  List<Tweet> story = [];
  List<User> followers = [];
  List<User> following = [];

  List<Tweet> hashtags = [];
}

//Authenticated User Singleton
class UserModelSingleton {
  AuthenticatedUser userModel;

  static final UserModelSingleton _instance = UserModelSingleton._internal();

  factory UserModelSingleton() {
    return _instance;
  }

  UserModelSingleton._internal() {
    userModel = AuthenticatedUser();
  }
}
