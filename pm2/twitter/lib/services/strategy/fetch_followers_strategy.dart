import 'package:twitter/services/mock/mock_user_list.dart';

import 'fetch_list_strategy.dart';

class FetchFollowersStrategy implements FetchListStrategy {
  @override
  Future fetchList() async {
    MockUserList mockUserList = MockUserList();

    return await mockUserList.getFollowers();
  }
}
