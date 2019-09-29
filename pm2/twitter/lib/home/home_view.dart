import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget _buildAppBar() {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
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
                      "Story",
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
                // TODO: Call each state here?
                Text(""),
                Text(""),
                Text(""),
                Text(""),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.blue[50],
      type: BottomNavigationBarType.fixed,
      currentIndex: 0, // th
      items: [
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(FontAwesomeIcons.home),
        ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(FontAwesomeIcons.search),
        ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(
            FontAwesomeIcons.plusCircle,
            size: 48,
            color: Colors.lightBlue,
          ),
        ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(FontAwesomeIcons.userAlt),
        ),
        BottomNavigationBarItem(
          title: Container(height: 0.0),
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      body: Container(
        child: _buildAppBar(),
      ),
    );
  }
}
