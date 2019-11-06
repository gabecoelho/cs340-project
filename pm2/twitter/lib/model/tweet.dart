class Tweet {
  String handle;
  String message;
  String picture;
  String attachment;
  DateTime timestamp;

  Tweet(
      {this.handle,
      this.message,
      this.picture,
      this.attachment,
      this.timestamp});

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        handle: json["handle"],
        message: json["message"],
        picture: json["picture"],
        attachment: json["attachment"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "handle": handle,
        "message": message,
        "picture": picture,
        "attachment": attachment,
        "timestamp": timestamp.toIso8601String(),
      };
}
