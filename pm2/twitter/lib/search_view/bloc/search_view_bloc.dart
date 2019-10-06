import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SearchViewBloc extends Bloc<SearchViewEvent, SearchViewState> {
  @override
  SearchViewState get initialState => InitialSearchViewState();

  @override
  Stream<SearchViewState> mapEventToState(
    SearchViewEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
