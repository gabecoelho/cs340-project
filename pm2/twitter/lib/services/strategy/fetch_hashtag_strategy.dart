import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';

class FetchHashtagStrategy extends FetchListStrategy {
  AuthenticatedUserSingleton authenticatedUserSingleton =
      AuthenticatedUserSingleton();
  ServiceFacade serviceFacade = ServiceFacade();
  @override
  Future fetchList(User user) async {
    final result = await serviceFacade.getHashtag(user.hashtag, 10,
        authenticatedUserSingleton.authenticatedUser.hashtagsLastKey);

    authenticatedUserSingleton.authenticatedUser.hashtagsLastKey =
        result.lastKey;

    List list = authenticatedUserSingleton.authenticatedUser.hashtags;
    list.addAll(result.getList());

    authenticatedUserSingleton.authenticatedUser.hashtags = list;

    if (authenticatedUserSingleton.authenticatedUser.user.handle ==
        AuthenticatedUserSingleton().authenticatedUser.user.handle) {
      AuthenticatedUserSingleton().authenticatedUser =
          authenticatedUserSingleton.authenticatedUser;
    }
    return authenticatedUserSingleton.authenticatedUser.hashtags;
  }
}
