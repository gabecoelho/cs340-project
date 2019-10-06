//any other user
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';

class UserModel {
  final User user;
  final List<Tweet> feed;
  final List<Tweet> story;
  final List<User> following;
  final List<User> followers;

  UserModel(this.user, this.feed, this.story, this.following, this.followers);

  // final userModel = UserModelSingleton();
}

//auth user

// class UserModelSingleton {
//   final UserModel userModel;

//   static final UserModelSingleton _instance = UserModelSingleton._internal();

//   factory UserModelSingleton() {
//     return _instance;
//   }

//   UserModelSingleton._internal() {
//     userModel = UserModel();
//   }
// }
