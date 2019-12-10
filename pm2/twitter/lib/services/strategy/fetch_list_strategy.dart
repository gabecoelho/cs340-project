import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';

abstract class FetchListStrategy {
  Future fetchList(User user);
}
