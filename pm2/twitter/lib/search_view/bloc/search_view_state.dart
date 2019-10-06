import 'package:equatable/equatable.dart';

abstract class SearchViewState extends Equatable {
  const SearchViewState();
}

class InitialSearchViewState extends SearchViewState {
  @override
  List<Object> get props => [];
}
