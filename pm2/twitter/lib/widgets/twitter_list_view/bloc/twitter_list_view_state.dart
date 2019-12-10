import 'package:equatable/equatable.dart';
import 'package:twitter/model/user.dart';

abstract class TwitterListViewState extends Equatable {
  const TwitterListViewState();

  List<Object> get props => [];
}

class TwitterListViewInitialState extends TwitterListViewState {}

class TwitterListViewLoadedState<T> extends TwitterListViewState {
  final List<T> list;

  TwitterListViewLoadedState(this.list) : super();

  @override
  List<Object> get props => list;
}

class TwitterListViewRefreshedState<T> extends TwitterListViewState {
  final List<T> list;

  TwitterListViewRefreshedState(this.list) : super();

  @override
  List<Object> get props => list;
}

class TwitterListViewUserTappedState extends TwitterListViewState {
  final User user;

  TwitterListViewUserTappedState(this.user) : super();

  @override
  List<Object> get props => [user];
}

class TwitterListViewHashtagTappedState<T> extends TwitterListViewState {
  final List<T> hashtags;

  TwitterListViewHashtagTappedState(this.hashtags) : super();

  @override
  List<Object> get props => hashtags;
}
