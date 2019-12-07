import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:twitter/facade/service_facade.dart';
import './bloc.dart';

class NewTweetBloc extends Bloc<NewTweetEvent, NewTweetState> {
  @override
  NewTweetState get initialState => InitialNewTweetState();
  ServiceFacade serviceFacade = ServiceFacade();

  @override
  Stream<NewTweetState> mapEventToState(
    NewTweetEvent event,
  ) async* {
    yield InitialNewTweetState();
    if (event is AttachmentAddedNewTweetEvent) {
      yield AttachmentAddedNewTweetState(image: event.image);
    }
    if (event is SendNewTweetEvent) {
      await serviceFacade.postTweet(event.tweet);
      yield TweetSentNewTweetState();
    }
  }
}
