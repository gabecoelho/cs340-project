import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:twitter/facade/service_facade.dart';
import 'package:twitter/hashtag/hashtag_view.dart';
import 'package:twitter/model/authenticated_user.dart';
import 'package:twitter/model/http_response_models/general_result.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/services/strategy/fetch_list_strategy.dart';
import 'package:twitter/single_user_view/single_user_view.dart';
import 'package:twitter/widgets/tweet_cell/tweet_cell.dart';
import 'bloc/twitter_list_view_event.dart';
import '../user_cell/user_cell.dart';
import 'bloc/twitter_list_view_bloc.dart';
import 'bloc/twitter_list_view_state.dart';

abstract class TweetInterface {
  void userTapped(String handle);
  void hashtagTapped(String hashtag);
}

class TwitterListView<T> extends StatefulWidget {
  final FetchListStrategy fetchListStrategy;
  final AuthenticatedUser authenticatedUser;

  const TwitterListView(
      {Key key,
      @required this.fetchListStrategy,
      @required this.authenticatedUser})
      : super(key: key);

  @override
  _TwitterListViewState<T> createState() => _TwitterListViewState<T>();
}

class _TwitterListViewState<T> extends State<TwitterListView<T>>
    implements TweetInterface {
  TwitterListViewBloc _bloc;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    _bloc = TwitterListViewBloc<T>(
        widget.fetchListStrategy, widget.authenticatedUser);
    _bloc.add(TwitterListViewFetchListEvent());
    super.initState();
  }

  _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _bloc.add(TwitterListViewRefreshEvent());

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          print(state.toString());
          if (state is TwitterListViewLoadedState ||
              state is TwitterListViewRefreshedState) {
            return SmartRefresher(
              enableTwoLevel: true,
              controller: _refreshController,
              // onRefresh: _onRefresh,
              onLoading: _onLoading,
              // enablePullDown: true,
              enablePullUp: true,
              // header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("Pull to load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed! Click to retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("Release to load");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, i) {
                  if (T == Tweet) {
                    final tweet = state.list[i];
                    return TweetCell(
                      handle: tweet.handle,
                      message: tweet.message,
                      timestamp: tweet.timestamp.toString(),
                      picture: tweet.picture,
                      attachment: tweet.attachment,
                      tweetInterface: this,
                    );
                  } else {
                    final user = state.list[i];
                    return UserCell(
                      user: user,
                    );
                  }
                },
              ),
              // ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void hashtagTapped(String hashtag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HashtagView(),
      ),
    );
  }

  @override
  void userTapped(String handle) {
    //TODO: get User
    User user = User(
      name: "John Doe",
      handle: handle,
      picture: "",
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleUserView(
          user: user,
          column: Column(),
        ),
      ),
    );
  }
}
