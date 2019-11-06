// To parse this JSON data, do
//
//     final feedResult = feedResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/http_response_models/general_result.dart';
import 'package:twitter/model/tweet.dart';

FeedResult feedResultFromJson(String str) =>
    FeedResult.fromJson(json.decode(str));

String feedResultToJson(FeedResult data) => json.encode(data.toJson());

class FeedResult extends GeneralResult {
  List<Tweet> feed;

  FeedResult({
    this.feed,
  });

  factory FeedResult.fromJson(Map<String, dynamic> json) => FeedResult(
        feed: List<Tweet>.from(
          json["feed"].map(
            (x) => Tweet.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "feed": List<dynamic>.from(
          feed.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List getList() {
    return feed;
  }
}
