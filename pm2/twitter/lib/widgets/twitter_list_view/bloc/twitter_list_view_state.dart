import 'package:equatable/equatable.dart';

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
