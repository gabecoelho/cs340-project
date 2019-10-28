import 'package:equatable/equatable.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();

  List<Object> get props => [];
}

class SwitchToProfilePageEvent extends MainViewEvent {}
