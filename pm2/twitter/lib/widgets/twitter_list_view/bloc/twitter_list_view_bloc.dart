import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import './bloc.dart';

class TwitterListViewBloc<T>
    extends Bloc<TwitterListViewEvent, TwitterListViewState> {
  TwitterListViewBloc(this.fetchListStrategy, this.authenticatedUser);

  final FetchListStrategy fetchListStrategy;
  final AuthenticatedUser authenticatedUser;

  @override
  TwitterListViewState get initialState => TwitterListViewInitialState();

  @override
  Stream<TwitterListViewState> mapEventToState(
    TwitterListViewEvent event,
  ) async* {
    if (event is TwitterListViewFetchListEvent) {
      final list = await this.fetchListStrategy.fetchList(authenticatedUser);
      yield TwitterListViewLoadedState(list);
    }

    if (event is TwitterListViewRefreshEvent) {
      final list = await this.fetchListStrategy.fetchList(authenticatedUser);
      yield TwitterListViewRefreshedState(list);
    }
  }
}
