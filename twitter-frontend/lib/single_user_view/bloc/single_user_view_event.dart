import 'package:equatable/equatable.dart';

abstract class SingleUserViewEvent extends Equatable {
  const SingleUserViewEvent();

  List<Object> get props => null;
}

class SingleUserViewCheckFollowsEvent extends SingleUserViewEvent {
  final String follower;
  final String followee;

  SingleUserViewCheckFollowsEvent({this.follower, this.followee});

  List<Object> get props => [follower, followee];
}

class SingleUserViewFollowEvent extends SingleUserViewEvent {
  final String follower;
  final String followee;
  final String followerName;
  final String followeeName;

  SingleUserViewFollowEvent(
      {this.follower, this.followee, this.followerName, this.followeeName});

  List<Object> get props => [follower, followee, followerName, followeeName];
}

class SingleUserViewUnfollowEvent extends SingleUserViewEvent {
  final String follower;
  final String followee;

  SingleUserViewUnfollowEvent({this.follower, this.followee});

  List<Object> get props => [follower, followee];
}
