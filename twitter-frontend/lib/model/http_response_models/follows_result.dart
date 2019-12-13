// To parse this JSON data, do
//
//     final followsResult = followsResultFromJson(jsonString);

import 'dart:convert';

FollowsResult followsResultFromJson(String str) =>
    FollowsResult.fromJson(json.decode(str));

String followsResultToJson(FollowsResult data) => json.encode(data.toJson());

class FollowsResult {
  bool follows;

  FollowsResult({
    this.follows,
  });

  factory FollowsResult.fromJson(Map<String, dynamic> json) => FollowsResult(
        follows: json["follows"],
      );

  Map<String, dynamic> toJson() => {
        "follows": follows,
      };
}
