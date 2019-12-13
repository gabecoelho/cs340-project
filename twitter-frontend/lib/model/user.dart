import 'dart:io';

import 'package:amazon_cognito_identity_dart/cognito.dart';

class User {
  String name;
  String handle;
  String picture;
  String hashtag;

  User({
    this.name,
    this.handle,
    this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["userName"],
        handle: json["userHandle"],
        picture: json["userPicture"],
      );

  /// Decode user from Cognito User Attributes
  factory User.fromUserAttributes(List<CognitoUserAttribute> attributes) {
    final user = User();
    attributes.forEach((attribute) {
      if (attribute.getName() == 'name') {
        user.name = attribute.getValue();
      } else if (attribute.getName() == 'preferred_username') {
        user.handle = attribute.getValue();
      } else if (attribute.getName() == 'picture') {
        user.picture = attribute.getValue();
      }
    });
    return user;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "handle": handle,
        "picture": picture,
      };
}
