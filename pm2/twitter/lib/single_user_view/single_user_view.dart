import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/single_user_view/bloc/bloc.dart';
import 'package:twitter/user_profile/user_profile_view.dart';
import 'package:twitter/widgets/twitter_list_view/bloc/twitter_list_view_state.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class SingleUserView extends StatefulWidget {
  final Column column;
  final User user;

  SingleUserView({this.column, this.user});

  @override
  _SingleUserViewState createState() => _SingleUserViewState();
}

class _SingleUserViewState extends State<SingleUserView> {
  TwitterListViewState twitterListViewState;
  SingleUserViewBloc _singleUserViewBloc;
  AuthenticatedUserSingleton authenticatedUserSingleton =
      AuthenticatedUserSingleton();
  RegExp regex = new RegExp(r"([^@]+)");

  @override
  void initState() {
    _singleUserViewBloc = BlocProvider.of<SingleUserViewBloc>(context);
    twitterListViewState = TwitterListViewUserTappedState(widget.user);

    _singleUserViewBloc.add(SingleUserViewCheckFollowsEvent(
        follower: authenticatedUserSingleton.authenticatedUser.user.handle,
        followee: widget.user.handle));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: _buildNewUserViewAppBar(context),
        body: Stack(
          children: <Widget>[
            _buildUpperPiece(context),
            _buildFollowButton(),
          ],
        ));
  }

  Widget _buildNewUserViewAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, false),
      ),
    );
  }

  Widget _buildUpperPiece(BuildContext context) {
    return Stack(children: <Widget>[
      UserProfileView(
        user: this.widget.user,
        isOtherUser: true,
      ),
    ]);
  }

  Widget _buildFollowButton() {
    final singleUserViewBloc = BlocProvider.of<SingleUserViewBloc>(context);

    return BlocProvider(
      builder: (context) => singleUserViewBloc,
      child: BlocBuilder(
          bloc: singleUserViewBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[_buildButton(state)],
            );
          }),
    );
  }

  Widget _buildButton(SingleUserViewState state) {
    return RaisedButton(
      child: Text(
        state.text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      color: Colors.lightBlue,
      onPressed: () {
        if (state is SingleUserViewShowFollowState) {
          _singleUserViewBloc.add(SingleUserViewFollowEvent(
              follower:
                  authenticatedUserSingleton.authenticatedUser.user.handle,
              followerName:
                  authenticatedUserSingleton.authenticatedUser.user.name,
              followee: this.widget.user.handle,
              followeeName: this.widget.user.name));
        } else if (state is SingleUserViewShowUnfollowState) {
          _singleUserViewBloc.add(
            SingleUserViewUnfollowEvent(
                follower:
                    authenticatedUserSingleton.authenticatedUser.user.handle,
                followee: regex.stringMatch(this.widget.user.handle)),
          );
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
    );
  }
}
