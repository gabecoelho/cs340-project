import 'package:equatable/equatable.dart';

abstract class TwitterListViewEvent extends Equatable {
  const TwitterListViewEvent();
}

class TwitterListViewFetchListEvent extends TwitterListViewEvent {}
