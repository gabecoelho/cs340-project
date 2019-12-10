// To parse this JSON data, do
//
//     final hashtagResult = hashtagResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/http_response_models/general_result.dart';

import '../tweet.dart';

HashtagResult hashtagResultFromJson(String str) =>
    HashtagResult.fromJson(json.decode(str));

String hashtagResultToJson(HashtagResult data) => json.encode(data.toJson());

class HashtagResult extends GeneralResult {
  List<Tweet> hashtags;
  String lastKey;

  HashtagResult({this.hashtags, this.lastKey});

  factory HashtagResult.fromJson(Map<String, dynamic> json) => HashtagResult(
        hashtags: List<Tweet>.from(
          json["hashtags"].map(
            (x) => Tweet.fromJson(x),
          ),
        ),
        lastKey: json["lastKey"],
      );

  Map<String, dynamic> toJson() => {
        "hashtags": List<dynamic>.from(hashtags.map((x) => x.toJson())),
        "lastKey": lastKey
      };

  @override
  List getList() {
    return hashtags;
  }
}
