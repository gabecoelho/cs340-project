// To parse this JSON data, do
//
//     final pictureUploadResult = pictureUploadResultFromJson(jsonString);

import 'dart:convert';

PictureUploadResult pictureUploadResultFromJson(String str) =>
    PictureUploadResult.fromJson(json.decode(str));

String pictureUploadResultToJson(PictureUploadResult data) =>
    json.encode(data.toJson());

class PictureUploadResult {
  String url;

  PictureUploadResult({
    this.url,
  });

  factory PictureUploadResult.fromJson(Map<String, dynamic> json) =>
      PictureUploadResult(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
