import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/model/authenticated_user.dart';
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
import 'package:twitter/user_profile/bloc/user_profile_event.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class UserProfileView extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;
  final User user;
  bool isOtherUser = false;

  UserProfileView({this.fetchListStrategy, this.user, this.isOtherUser});

  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  AuthenticatedUserSingleton userModelSingleton = AuthenticatedUserSingleton();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData;

  void changeProfileImage(
      ImageSource imageSource, ProfileBloc profileBloc) async {
    final image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      profileBloc.add(
        ProfilePictureChangedEvent(image: image),
      );
    }
    List<int> imageBytes = image.readAsBytesSync();
    _formData['picture'] = base64Encode(imageBytes);

    profileBloc.add(UserProfileChangedPictureEvent(
        base64EncodedString: _formData['picture'],
        handle: userModelSingleton.authenticatedUser.user.handle));
  }

  @override
  void initState() {
    _formData = {
      'picture': '',
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ProfileInitialEvent());
    return Scaffold(
      body: BlocProvider(
        builder: (context) => ProfileBloc(),
        child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, state) {
              return _buildUserProfile(
                  widget.user, profileBloc, state, widget.isOtherUser);
            }),
      ),
    );
  }

  Widget _buildUserProfile(User user, ProfileBloc profileBloc,
      ProfileState state, bool isOtherUser) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              backgroundImage: isOtherUser != true
                  ? NetworkImage(
                      (userModelSingleton.authenticatedUser.user.picture)
                          .replaceAll("\"", ""))
                  : NetworkImage(widget.user.picture.replaceAll("\"", "")),
              radius: 80,
            ),
            onTap: () {
              if (isOtherUser == false)
                changeProfileImage(ImageSource.gallery, profileBloc);
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
            child: isOtherUser != true
                ? Text(
                    userModelSingleton.authenticatedUser.user.name,
                    style: TextStyle(fontSize: 40),
                  )
                : Text(
                    widget.user.name,
                    style: TextStyle(fontSize: 40),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
            child: isOtherUser != true
                ? Text(
                    "@" + userModelSingleton.authenticatedUser.user.handle,
                    style: TextStyle(fontSize: 25),
                  )
                : Text(
                    "@" + widget.user.handle,
                    style: TextStyle(fontSize: 25),
                  ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Followers",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                    fetchListStrategy: FetchFollowersStrategy(),
                    user: widget.user,
                  ),
                ),
              );
            },
          ),
          InkWell(
            child: Text(
              "Following",
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFollowView(
                      fetchListStrategy: FetchFollowingStrategy(),
                      user: widget.user),
                ),
              );
            },
          ),
          Divider(),
          Expanded(
            child: TwitterListView<Tweet>(
              fetchListStrategy: FetchStoryStrategy(),
              user: isOtherUser == true
                  ? widget.user
                  : userModelSingleton.authenticatedUser.user,
            ),
          ),
        ],
      ),
    );
  }
}
