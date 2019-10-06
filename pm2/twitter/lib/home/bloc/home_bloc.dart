import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../home_view.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    yield HomeInitialState();
  }
}
