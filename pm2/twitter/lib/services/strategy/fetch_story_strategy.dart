import 'package:twitter/services/mock/mock_tweet_list.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchStoryStrategy implements FetchListStrategy {
  @override
  Future fetchList() async {
    MockTweetList mockTweetList = MockTweetList();

    return await mockTweetList.getStory();
  }
}
