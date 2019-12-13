import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/single_user_view/single_user_view.dart';
import 'package:twitter/widgets/user_cell/bloc/bloc.dart';
import 'bloc/user_cell_bloc.dart';

class UserCell extends StatefulWidget {
  final User user;

  UserCell({this.user}) : super();

  @override
  _UserCellState createState() => _UserCellState();
}

class _UserCellState extends State<UserCell> {
  @override
  Widget build(BuildContext context) {
    final _userCellBloc = BlocProvider.of<UserCellBloc>(context);

    return BlocProvider(
      builder: (context) => _userCellBloc,
      child: BlocListener(
        bloc: _userCellBloc,
        listener: (context, state) {
          print(state.user.name);
          if (state is UserCellClickedState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleUserView(
                  user: state.user,
                  // column: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     CircleAvatar(
                  //       backgroundImage: NetworkImage(state.user.picture),
                  //       radius: 80,
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text("Followers"),
                  //     ),
                  //     Text("Following"),
                  //     Divider(),
                  //   ],
                  // ),
                ),
              ),
            );
          }
        },
        child: BlocBuilder(
            bloc: _userCellBloc,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.picture),
                      radius: 25,
                    ),
                    title: Text(widget.user.name),
                    subtitle: Text(widget.user.handle),
                    onTap: () {
                      print("on tapped!!");
                      _userCellBloc.add(
                        UserCellClickedEvent(handle: widget.user.handle),
                      );
                    },
                  ),
                  Divider()
                ],
              );
            }),
      ),
    );
  }
}
