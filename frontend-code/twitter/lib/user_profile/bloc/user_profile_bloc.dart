import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/user_profile/bloc/user_profile_event.dart';
import 'package:twitter/user_profile/bloc/user_profile_state.dart';

class UserPageBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final FetchListStrategy fetchListStrategy;

  UserPageBloc(this.fetchListStrategy);

  @override
  UserProfileState get initialState => InitialUserProfileState();

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {}
}
