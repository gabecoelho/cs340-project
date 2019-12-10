import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/new_tweet/new_tweet_view.dart';
import 'package:twitter/services/strategy/fetch_feed_strategy.dart';
import 'package:twitter/services/strategy/fetch_followers_strategy.dart';
import 'package:twitter/services/strategy/fetch_following_strategy.dart';
import 'package:twitter/widgets/twitter_list_view/twitter_list_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthenticatedUserSingleton userModelSingleton = AuthenticatedUserSingleton();

  int currentIndex = 0;

  Widget _buildAppBar(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 10.0,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Feed",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Following",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Followers",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              title: Icon(
                FontAwesomeIcons.twitter,
                size: 55,
                color: Colors.white,
              ),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TwitterListView<Tweet>(
                    fetchListStrategy: FetchFeedStrategy(),
                    user: userModelSingleton.authenticatedUser.user,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TwitterListView<User>(
                    fetchListStrategy: FetchFollowingStrategy(),
                    user: userModelSingleton.authenticatedUser.user,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TwitterListView<User>(
                    fetchListStrategy: FetchFollowersStrategy(),
                    user: userModelSingleton.authenticatedUser.user,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                FontAwesomeIcons.envira,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTweetView()));
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildAppBar(context),
      ),
    );
  }
}
