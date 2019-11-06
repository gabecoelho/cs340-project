// To parse this JSON data, do
//
//     final followResult = followResultFromJson(jsonString);

import 'dart:convert';

FollowResult followResultFromJson(String str) =>
    FollowResult.fromJson(json.decode(str));

String followResultToJson(FollowResult data) => json.encode(data.toJson());

class FollowResult {
  String follower;
  String following;
  bool follows;

  FollowResult({
    this.follower,
    this.following,
    this.follows,
  });

  factory FollowResult.fromJson(Map<String, dynamic> json) => FollowResult(
        follower: json["follower"],
        following: json["following"],
        follows: json["follows"],
      );

  Map<String, dynamic> toJson() => {
        "follower": follower,
        "following": following,
        "follows": follows,
      };
}
