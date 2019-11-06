import 'package:twitter/model/authenticated_user.dart';

abstract class FetchListStrategy {
  Future fetchList(AuthenticatedUser authenticatedUser);
}
