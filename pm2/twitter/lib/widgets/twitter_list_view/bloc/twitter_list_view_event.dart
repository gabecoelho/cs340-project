import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class TwitterListViewEvent extends Equatable {
  const TwitterListViewEvent();

  List<Object> get props => null;
}

class TwitterListViewFetchListEvent extends TwitterListViewEvent {}

class TwitterListViewRefreshEvent extends TwitterListViewEvent {}

class TwitterListViewUserTappedEvent extends TwitterListViewEvent {
  final String handle;

  TwitterListViewUserTappedEvent({@required this.handle});

  @override
  List<Object> get props => [handle];
}

class TwitterListViewHashtagTappedEvent extends TwitterListViewEvent {
  final String hashtag;

  TwitterListViewHashtagTappedEvent({@required this.hashtag});

  @override
  List<Object> get props => [hashtag];
}
