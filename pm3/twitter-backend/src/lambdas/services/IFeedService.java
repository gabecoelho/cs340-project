package lambdas.services;

import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

public interface IFeedService {
    TweetPostResult postTweet(TweetPostRequest request);
}
