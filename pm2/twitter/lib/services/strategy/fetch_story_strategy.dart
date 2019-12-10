import 'dart:async';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/http_response_models/story_result.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/mock/mock_tweet_list.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchStoryStrategy implements FetchListStrategy {
  ServiceFacade serviceFacade = ServiceFacade();
  AuthenticatedUserSingleton authenticatedUserSingleton =
      AuthenticatedUserSingleton();
  @override
  Future fetchList(User user) async {
    // MockTweetList mockTweetList = MockTweetList();
    // return await mockTweetList.getStory();

    print(authenticatedUserSingleton.authenticatedUser.storyLastKey);

    final result = await serviceFacade.getStory(user.handle, 10,
        authenticatedUserSingleton.authenticatedUser.storyLastKey);

    try {
      print(result.lastKey);
    } catch (e) {
      e.toString();
    }

    authenticatedUserSingleton.authenticatedUser.storyLastKey = result.lastKey;

    List list = authenticatedUserSingleton.authenticatedUser.story;
    list.addAll(result.getList());

    authenticatedUserSingleton.authenticatedUser.story = list;

    if (user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser =
          authenticatedUserSingleton.authenticatedUser;
    }
    return authenticatedUserSingleton.authenticatedUser.story;
  }
}
