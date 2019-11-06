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
    final result = await serviceFacade.getStory("username");

    List list = authenticatedUser.story;
    list.addAll(result.getList());
    authenticatedUser.story = list;

    if (authenticatedUser.user.handle ==
        UserModelSingleton().userModel.user.handle) {
      UserModelSingleton().userModel = authenticatedUser;
    }
    return authenticatedUser.story;
  }
}
