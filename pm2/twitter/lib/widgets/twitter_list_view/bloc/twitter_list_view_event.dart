import 'package:equatable/equatable.dart';

abstract class TwitterListViewEvent extends Equatable {
  const TwitterListViewEvent();

  List<Object> get props => null;
}

class TwitterListViewFetchListEvent extends TwitterListViewEvent {}

class TwitterListViewRefreshEvent extends TwitterListViewEvent {}
