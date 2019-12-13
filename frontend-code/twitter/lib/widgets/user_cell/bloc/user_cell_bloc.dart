import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/model/http_response_models/user_result.dart';
import './bloc.dart';

class UserCellBloc extends Bloc<UserCellEvent, UserCellState> {
  @override
  UserCellState get initialState => InitialUserCellState();
  ServiceFacade serviceFacade = ServiceFacade();

  @override
  Stream<UserCellState> mapEventToState(
    UserCellEvent event,
  ) async* {
    if (event is UserCellClickedEvent) {
      UserResult result = await serviceFacade.getUser(event.handle);
      yield UserCellClickedState(user: result.user);
    }
  }
}
