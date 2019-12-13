// To parse this JSON data, do
//
//     final userResult = userResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/user.dart';

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
