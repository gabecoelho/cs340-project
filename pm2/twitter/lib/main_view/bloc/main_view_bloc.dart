import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  @override
  MainViewState get initialState => MainViewInitialState();

  @override
  Stream<MainViewState> mapEventToState(
    MainViewEvent event,
  ) async* {
    yield MainViewInitialState();
    if (event is SwitchToProfilePageEvent) {
      // yield
    }
  }
}
