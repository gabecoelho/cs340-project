import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/mock/mock_user_list.dart';

import 'fetch_list_strategy.dart';

class FetchFollowersStrategy implements FetchListStrategy {
  AuthenticatedUserSingleton authenticatedUserSingleton =
      AuthenticatedUserSingleton();

  ServiceFacade serviceFacade = ServiceFacade();
  @override
  Future fetchList(User user) async {
    // MockUserList mockUserList = MockUserList();
    // return await mockUserList.getFollowers();

    final result = await serviceFacade.getFollowers(user.handle, 10,
        authenticatedUserSingleton.authenticatedUser.followersLastKey);

    authenticatedUserSingleton.authenticatedUser.followersLastKey =
        result.lastKey;

    List list = authenticatedUserSingleton.authenticatedUser.followers;
    list.addAll(result.getList());

    authenticatedUserSingleton.authenticatedUser.followers = list;

    if (authenticatedUserSingleton.authenticatedUser.user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser =
          authenticatedUserSingleton.authenticatedUser;
    }
    return authenticatedUserSingleton.authenticatedUser.followers;
  }
}
