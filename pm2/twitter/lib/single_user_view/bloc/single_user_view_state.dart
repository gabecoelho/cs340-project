import 'package:equatable/equatable.dart';

abstract class SingleUserViewState extends Equatable {
  const SingleUserViewState();
  final text = "";

  List<Object> get props => [];
}

class InitialSingleUserViewState extends SingleUserViewState {}

class SingleUserViewShowFollowState extends SingleUserViewState {
  final String text = "Follow";
}

class SingleUserViewShowUnfollowState extends SingleUserViewState {
  final String text = "Unfollow";
}
