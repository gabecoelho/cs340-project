import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NewTweetBloc extends Bloc<NewTweetEvent, NewTweetState> {
  @override
  NewTweetState get initialState => InitialNewTweetState();

  @override
  Stream<NewTweetState> mapEventToState(
    NewTweetEvent event,
  ) async* {
    yield InitialNewTweetState();
    if (event is AttachmentAddedNewTweetEvent) {
      yield AttachmentAddedNewTweetState(image: event.image);
    }
  }
}
