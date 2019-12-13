import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/http_response_models/feed_result.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/mock/mock_tweet_list.dart';

class FetchFeedStrategy implements FetchListStrategy {
  ServiceFacade serviceFacade = ServiceFacade();
  AuthenticatedUserSingleton authenticatedUserSingleton =
      AuthenticatedUserSingleton();
  @override
  Future fetchList(User user) async {
    // MockTweetList mockTweetList = MockTweetList();
    // return await mockTweetList.getFeed();

    final result = await serviceFacade.getFeed(user.handle, 10,
        authenticatedUserSingleton.authenticatedUser.feedLastKey);

    authenticatedUserSingleton.authenticatedUser.feedLastKey = result.lastKey;

    List list = authenticatedUserSingleton.authenticatedUser.feed;
    list.addAll(result.getList());

    authenticatedUserSingleton.authenticatedUser.feed = list;

    if (user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser =
          authenticatedUserSingleton.authenticatedUser;
    }
    return authenticatedUserSingleton.authenticatedUser.feed;
  }
}
