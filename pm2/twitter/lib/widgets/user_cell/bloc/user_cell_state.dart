import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter/model/user.dart';

abstract class UserCellState extends Equatable {
  const UserCellState();
  List<Object> get props => [];
}

class InitialUserCellState extends UserCellState {}

class UserCellClickedState extends UserCellState {
  final User user;

  UserCellClickedState({@required this.user});

  List<Object> get props => [user];
}
