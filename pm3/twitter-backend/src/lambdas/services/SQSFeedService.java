package lambdas.services;

import lambdas.dao.FeedDAO;
import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

public class SQSFeedService implements IFeedService {

    FeedDAO feedDAO = new FeedDAO();

    @Override
    public TweetPostResult postTweet(TweetPostRequest request) {
        return null;
    }
}
