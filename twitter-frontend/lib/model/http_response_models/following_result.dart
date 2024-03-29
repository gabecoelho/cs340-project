// To parse this JSON data, do
//
//     final followingResult = followingResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/http_response_models/general_result.dart';
import 'package:twitter/model/user.dart';

FollowingResult followingResultFromJson(String str) =>
    FollowingResult.fromJson(json.decode(str));

String followingResultToJson(FollowingResult data) =>
    json.encode(data.toJson());

class FollowingResult extends GeneralResult {
  List<User> following;
  String lastKey;

  FollowingResult({this.following, this.lastKey});

  factory FollowingResult.fromJson(Map<String, dynamic> json) =>
      FollowingResult(
          following:
              List<User>.from(json["following"].map((x) => User.fromJson(x))),
          lastKey: json["lastKey"]);

  Map<String, dynamic> toJson() => {
        "following": List<dynamic>.from(following.map((x) => x.toJson())),
        "lastKey": lastKey
      };

  @override
  List getList() {
    return following;
  }
}
