import 'package:equatable/equatable.dart';

abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitialState extends StoryState {
  @override
  List<Object> get props => [];
}
