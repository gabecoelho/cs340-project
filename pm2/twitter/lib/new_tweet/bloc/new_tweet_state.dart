import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NewTweetState extends Equatable {
  NewTweetState([List props = const <dynamic>[]]);

  List<Object> get props => null;
}

class InitialNewTweetState extends NewTweetState {}

class AttachmentAddedNewTweetState extends NewTweetState {
  final File image;

  AttachmentAddedNewTweetState({@required this.image}) : super([image]);

  @override
  List<Object> get props => [image];
}
