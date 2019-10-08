import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/profile_creation/bloc/profile_creation_bloc.dart';
import 'package:twitter/profile_creation/bloc/profile_creation_event.dart';
import 'package:twitter/profile_creation/bloc/profile_creation_state.dart';
import 'package:twitter/services/strategy/fetch_followers_strategy.dart';
import 'package:twitter/services/strategy/fetch_following_strategy.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/services/strategy/fetch_story_strategy.dart';
import 'package:twitter/user_follow_view/user_follow_view.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class UserProfileView extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;
  final User user;

  UserProfileView.empty(this.fetchListStrategy, this.user);

  UserProfileView({this.fetchListStrategy, this.user}) : super();

  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  void changeProfileImage(
      ImageSource imageSource, ProfileBloc profileBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      profileBloc.dispatch(
        ProfilePictureChangedEvent(image: image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      body: BlocProvider(
        builder: (context) => ProfileBloc(),
        child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, state) {
              return _buildUserProfile(widget.user, profileBloc, state);
            }),
      ),
    );
  }

  Widget _buildUserProfile(
      User user, ProfileBloc profileBloc, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              backgroundImage: state is ProfilePictureChangedState
                  ? FileImage(state.image)
                  : FileImage(user.picture),
              radius: 80,
            ),
            onTap: () {
              changeProfileImage(ImageSource.gallery, profileBloc);
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${user.followers.length} Followers"),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                      fetchListStrategy: FetchFollowersStrategy()),
                ),
              );
            },
          ),
          InkWell(
            child: Text("${user.following.length} Following"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                      fetchListStrategy: FetchFollowingStrategy()),
                ),
              );
            },
          ),
          Divider(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TwitterListView<Tweet>(
                fetchListStrategy: FetchStoryStrategy(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
