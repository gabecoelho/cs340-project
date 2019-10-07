import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NewTweetState extends Equatable {
  NewTweetState([List props = const <dynamic>[]]) : super(props);
}

class InitialNewTweetState extends NewTweetState {
  @override
  List<Object> get props => [];
}

class AttachmentAddedNewTweetState extends NewTweetState {
  final File image;

  AttachmentAddedNewTweetState({@required this.image}) : super([image]);
}
