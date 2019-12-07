import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/http_response_models/feed_result.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/mock/mock_tweet_list.dart';

class FetchFeedStrategy implements FetchListStrategy {
  @override
  Future fetchList(AuthenticatedUser authenticatedUser) async {
    // MockTweetList mockTweetList = MockTweetList();
    // return await mockTweetList.getFeed();

    ServiceFacade serviceFacade = ServiceFacade();
    FeedResult result =
        await serviceFacade.getFeed(authenticatedUser.user.handle, 10, "");

    List list = authenticatedUser.feed;
    list.clear();
    list.addAll(result.getList());

    authenticatedUser.feed = list;

    if (authenticatedUser.user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser = authenticatedUser;
    }

    return authenticatedUser.feed;
  }
}
