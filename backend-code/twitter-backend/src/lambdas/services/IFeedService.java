package lambdas.services;

import lambdas.sqs.PostToSQSRequest;
import lambdas.tweetPoster.TweetPostRequest;

public interface IFeedService {
    void postTweetToFirstSQS(TweetPostRequest request);
    void postTweetToSecondSQS(PostToSQSRequest request);
}
