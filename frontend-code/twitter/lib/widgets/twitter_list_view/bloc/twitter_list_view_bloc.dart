import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/http_response_models/hashtag_result.dart';
import 'package:twitter/model/http_response_models/user_result.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import './bloc.dart';

class TwitterListViewBloc<T>
    extends Bloc<TwitterListViewEvent, TwitterListViewState> {
  TwitterListViewBloc(this.fetchListStrategy, this.user);

  final FetchListStrategy fetchListStrategy;
  final User user;

  @override
  TwitterListViewState get initialState => TwitterListViewInitialState();

  @override
  Stream<TwitterListViewState> mapEventToState(
    TwitterListViewEvent event,
  ) async* {
    if (event is TwitterListViewFetchListEvent) {
      final list = await this.fetchListStrategy.fetchList(user);
      yield TwitterListViewLoadedState(list);
    }

    if (event is TwitterListViewRefreshEvent) {
      final list = await this.fetchListStrategy.fetchList(user);
      yield TwitterListViewRefreshedState(list);
    }

    if (event is TwitterListViewUserTappedEvent) {
      final UserResult userResult = await ServiceFacade().getUser(event.handle);
      yield TwitterListViewUserTappedState(userResult.user);
    }

    if (event is TwitterListViewHashtagTappedEvent) {
      user.hashtag = event.hashtag;
      final hashtagResult = await this.fetchListStrategy.fetchList(user);
      yield TwitterListViewHashtagTappedState(hashtagResult);
    }
  }
}
