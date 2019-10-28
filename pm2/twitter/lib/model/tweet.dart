import 'dart:io';

class Tweet {
  final String username;
  final String handle;
  final String message;
  final String timestamp;
  final File image;
  File attachment;

  Tweet(this.username, this.handle, this.message, this.timestamp, this.image,
      {this.attachment});

  Future getImageUrl() {}
}
