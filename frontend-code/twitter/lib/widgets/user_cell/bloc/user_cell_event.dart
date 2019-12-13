import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserCellEvent extends Equatable {
  const UserCellEvent();
  List<Object> get props => null;
}

class UserCellClickedEvent extends UserCellEvent {
  final String handle;

  UserCellClickedEvent({@required this.handle});

  List<Object> get props => [handle];
}
