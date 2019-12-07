import 'dart:async';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/services/mock/mock_tweet_list.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchStoryStrategy implements FetchListStrategy {
  @override
  Future fetchList(AuthenticatedUser authenticatedUser) async {
    // MockTweetList mockTweetList = MockTweetList();
    // return await mockTweetList.getStory();
    ServiceFacade serviceFacade = ServiceFacade();

    // String lastKey = authenticatedUser.story.last.timestamp;

    final result =
        await serviceFacade.getStory(authenticatedUser.user.handle, 5, "");

    List list = authenticatedUser.story;
    list.clear();
    list.addAll(result.getList());
    // list.sort((a, b) => a.compareTo(b));

    authenticatedUser.story = list;

    if (authenticatedUser.user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser = authenticatedUser;
    }
    return authenticatedUser.story;
  }
}
