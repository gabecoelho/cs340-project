import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/http_response_models/follows_result.dart';
import './bloc.dart';

class SingleUserViewBloc
    extends Bloc<SingleUserViewEvent, SingleUserViewState> {
  ServiceFacade serviceFacade = ServiceFacade();

  @override
  SingleUserViewState get initialState => InitialSingleUserViewState();

  @override
  Stream<SingleUserViewState> mapEventToState(
    SingleUserViewEvent event,
  ) async* {
    if (event is SingleUserViewCheckFollowsEvent) {
      FollowsResult followsResult =
          await serviceFacade.follows(event.follower, event.followee);

      if (followsResult.follows == true)
        yield SingleUserViewShowUnfollowState();
      else
        yield SingleUserViewShowFollowState();
    }

    if (event is SingleUserViewFollowEvent) {
      await serviceFacade.follow(event.follower, event.followee,
          event.followerName, event.followeeName);

      yield SingleUserViewShowUnfollowState();
    }
    if (event is SingleUserViewUnfollowEvent) {
      await serviceFacade.unfollow(event.follower, event.followee);
      yield SingleUserViewShowFollowState();
    }
  }
}
