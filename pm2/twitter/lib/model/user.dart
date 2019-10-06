import 'dart:io';

class User {
  final String name;
  final String handle;
  final String email;
  final File picture;
  final List<User> followers;
  final List<User> following;

  User(this.name, this.handle, this.email, this.picture, this.followers,
      this.following);
}
