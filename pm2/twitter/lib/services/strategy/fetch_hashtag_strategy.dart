import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchHashtagStrategy extends FetchListStrategy {
  @override
  Future fetchList(AuthenticatedUser authenticatedUser) async {
    ServiceFacade serviceFacade = ServiceFacade();
    final result = await serviceFacade.getHashtag("something");

    List list = authenticatedUser.hashtags;
    list.addAll(result.getList());
    authenticatedUser.hashtags = list;

    if (authenticatedUser.user.handle ==
        UserModelSingleton().userModel.user.handle) {
      UserModelSingleton().userModel = authenticatedUser;
    }
    return authenticatedUser.hashtags;
  }
}
