import 'package:equatable/equatable.dart';

abstract class MainViewEvent extends Equatable {
  const MainViewEvent();
}

class SwitchToProfilePageEvent extends MainViewEvent {}
