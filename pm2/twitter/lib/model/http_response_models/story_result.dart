// To parse this JSON data, do
//
//     final storyResult = storyResultFromJson(jsonString);

import 'dart:convert';

import 'package:twitter/model/http_response_models/general_result.dart';
import 'package:twitter/model/tweet.dart';

StoryResult storyResultFromJson(String str) =>
    StoryResult.fromJson(json.decode(str));

String storyResultToJson(StoryResult data) => json.encode(data.toJson());

class StoryResult extends GeneralResult {
  List<Tweet> story;

  StoryResult({
    this.story,
  });

  factory StoryResult.fromJson(Map<String, dynamic> json) => StoryResult(
        story: List<Tweet>.from(json["story"].map((x) => Tweet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "story": List<dynamic>.from(story.map((x) => x.toJson())),
      };

  @override
  List getList() {
    return story;
  }
}
