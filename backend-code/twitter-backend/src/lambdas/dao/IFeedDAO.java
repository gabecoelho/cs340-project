package lambdas.dao;

import lambdas.feed.AddToFeedRequest;
import lambdas.feed.FeedResult;
import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

import java.util.List;

public interface IFeedDAO {
    FeedResult getFeed(String handle, int pageSize, String lastResult);
//    void addToFeed(AddToFeedRequest request);
    void batchWriteToFeed(TweetPostRequest request, List<String> followersList);
}
