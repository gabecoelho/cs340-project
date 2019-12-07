import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchHashtagStrategy extends FetchListStrategy {
  @override
  Future fetchList(AuthenticatedUser authenticatedUser) async {
    ServiceFacade serviceFacade = ServiceFacade();
    //TODO: pass real hashtag here
    final result = await serviceFacade.getHashtag("#test", 10, "");

    List list = authenticatedUser.hashtags;
    list.clear();
    list.addAll(result.getList());

    authenticatedUser.hashtags = list;

    if (authenticatedUser.user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser = authenticatedUser;
    }
    return authenticatedUser.hashtags;
  }
}
