import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  @override
  StoryState get initialState => StoryInitialState();

  @override
  Stream<StoryState> mapEventToState(
    StoryEvent event,
  ) async* {
  
  }
}
