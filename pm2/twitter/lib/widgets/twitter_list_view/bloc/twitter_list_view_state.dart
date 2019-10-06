import 'package:equatable/equatable.dart';

abstract class TwitterListViewState extends Equatable {
  const TwitterListViewState();
}

class TwitterListViewInitialState extends TwitterListViewState {
  @override
  List<Object> get props => [];
}

class TwitterListViewLoadedState<T> extends TwitterListViewState {
  final List<T> list;

  TwitterListViewLoadedState(this.list) : super();
}
