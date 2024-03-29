// To parse this JSON data, do
//
//     final postTweetResult = postTweetResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/tweet.dart';

PostTweetResult postTweetResultFromJson(String str) =>
    PostTweetResult.fromJson(json.decode(str));

String postTweetResultToJson(PostTweetResult data) =>
    json.encode(data.toJson());

class PostTweetResult {
  String success;

  PostTweetResult({
    this.success,
  });

  factory PostTweetResult.fromJson(Map<String, dynamic> json) =>
      PostTweetResult(
        success: (json["tweet"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}

// class Tweet {
//   String handle;
//   String message;
//   String picture;
//   String timestamp;
//   String attachment;

//   Tweet({
//     this.handle,
//     this.message,
//     this.picture,
//     this.timestamp,
//     this.attachment,
//   });

//   factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
//         handle: json["handle"],
//         message: json["message"],
//         picture: json["picture"],
//         timestamp: json["timestamp"],
//         attachment: json["attachment"],
//       );

//   Map<String, dynamic> toJson() => {
//         "handle": handle,
//         "message": message,
//         "picture": picture,
//         "timestamp": timestamp,
//         "attachment": attachment,
//       };
// }
