class Tweet {
  String handle;
  String name;
  String message;
  String picture;
  String attachment;
  //DateTime timestamp;
  String timestamp;

  Tweet(
      {this.handle,
      this.message,
      this.name,
      this.picture,
      this.attachment,
      this.timestamp});

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        handle: json["userHandle"],
        name: json["userName"],
        message: json["message"],
        picture: json["userPhoto"],
        attachment: json["attachment"],
        timestamp: (json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "handle": handle,
        "name": name,
        "message": message,
        "picture": picture,
        "attachment": attachment,
        "timestamp": timestamp,
      };
}
