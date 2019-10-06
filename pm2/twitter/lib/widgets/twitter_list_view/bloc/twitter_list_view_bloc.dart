import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import './bloc.dart';

class TwitterListViewBloc<T>
    extends Bloc<TwitterListViewEvent, TwitterListViewState> {
  final FetchListStrategy fetchListStrategy;

  TwitterListViewBloc(this.fetchListStrategy);

  @override
  TwitterListViewState get initialState => TwitterListViewInitialState();

  @override
  Stream<TwitterListViewState> mapEventToState(
    TwitterListViewEvent event,
  ) async* {
    if (event is TwitterListViewFetchListEvent) {
      final list = await this.fetchListStrategy.fetchList();
      yield TwitterListViewLoadedState(list);
    }
  }
}
