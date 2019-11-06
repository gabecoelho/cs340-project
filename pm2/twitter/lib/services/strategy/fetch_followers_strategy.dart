import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/services/mock/mock_user_list.dart';

import 'fetch_list_strategy.dart';

class FetchFollowersStrategy implements FetchListStrategy {
  @override
  Future fetchList(AuthenticatedUser authenticatedUser) async {
    // MockUserList mockUserList = MockUserList();
    // return await mockUserList.getFollowers();

    ServiceFacade serviceFacade = ServiceFacade();
    final result = await serviceFacade.getFollowers("username");

    List list = authenticatedUser.followers;
    list.addAll(result.getList());
    authenticatedUser.followers = list;

    if (authenticatedUser.user.handle ==
        UserModelSingleton().userModel.user.handle) {
      UserModelSingleton().userModel = authenticatedUser;
    }

    return authenticatedUser.followers;
  }
}
