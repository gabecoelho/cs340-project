// To parse this JSON data, do
//
//     final followersResult = followersResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/http_response_models/general_result.dart';
import 'package:twitter/model/user.dart';

FollowersResult followersResultFromJson(String str) =>
    FollowersResult.fromJson(json.decode(str));

String followersResultToJson(FollowersResult data) =>
    json.encode(data.toJson());

class FollowersResult extends GeneralResult {
  List<User> followers;
  String lastKey;

  FollowersResult({this.followers, this.lastKey});

  factory FollowersResult.fromJson(Map<String, dynamic> json) =>
      FollowersResult(
        followers:
            List<User>.from(json["followers"].map((x) => User.fromJson(x))),
        lastKey: json["lastKey"],
      );

  Map<String, dynamic> toJson() => {
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
        "lastKey": lastKey
      };

  @override
  List getList() {
    return followers;
  }
}
