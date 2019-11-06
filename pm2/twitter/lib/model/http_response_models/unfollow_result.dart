// To parse this JSON data, do
//
//     final unfollowResult = unfollowResultFromJson(jsonString);

import 'dart:convert';

UnfollowResult unfollowResultFromJson(String str) =>
    UnfollowResult.fromJson(json.decode(str));

String unfollowResultToJson(UnfollowResult data) => json.encode(data.toJson());

class UnfollowResult {
  String follower;
  String following;
  bool follows;

  UnfollowResult({
    this.follower,
    this.following,
    this.follows,
  });

  factory UnfollowResult.fromJson(Map<String, dynamic> json) => UnfollowResult(
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
