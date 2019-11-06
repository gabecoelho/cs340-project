// To parse this JSON data, do
//
//     final userResult = userResultFromJson(jsonString);

import 'dart:convert';

UserResult userResultFromJson(String str) =>
    UserResult.fromJson(json.decode(str));

String userResultToJson(UserResult data) => json.encode(data.toJson());

class UserResult {
  User user;

  UserResult({
    this.user,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) => UserResult(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  String name;
  String handle;
  String picture;

  User({
    this.name,
    this.handle,
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        handle: json["handle"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "handle": handle,
        "picture": picture,
      };
}
