import 'dart:io';

class User {
  final String name;
  final String handle;
  final String picture;

  User({
    this.name,
    this.handle,
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        handle: json["handle"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "handle": handle,
        "picture": picture,
      };
}
