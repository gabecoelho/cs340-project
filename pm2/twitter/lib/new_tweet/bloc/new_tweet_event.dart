import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NewTweetEvent extends Equatable {
  NewTweetEvent([List props = const <dynamic>[]]) : super(props);
}

class AttachmentAddedNewTweetEvent extends NewTweetEvent {
  final File image;

  AttachmentAddedNewTweetEvent({@required this.image}) : super([image]);
}
