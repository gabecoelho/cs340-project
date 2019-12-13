import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:twitter/model/tweet.dart';

abstract class NewTweetEvent extends Equatable {
  @override
  List<Object> get props => null;

  NewTweetEvent([List props = const <dynamic>[]]);
}

class AttachmentAddedNewTweetEvent extends NewTweetEvent {
  final File image;

  AttachmentAddedNewTweetEvent({@required this.image});

  @override
  List<Object> get props => [image];
}

class SendNewTweetEvent extends NewTweetEvent {
  final Tweet tweet;

  SendNewTweetEvent({@required this.tweet});

  @override
  List<Object> get props => [tweet];
}
