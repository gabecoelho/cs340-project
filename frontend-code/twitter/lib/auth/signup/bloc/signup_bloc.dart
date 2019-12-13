import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/services/real/user_service.dart';
import '../../bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  @override
  SignupState get initialState => SignupInitialState();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupSubmitEvent) {
      // Call service, then:
      yield NextPageFromSignupState();
    }
  }
}
