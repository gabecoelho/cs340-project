package lambdas.dao;

import lambdas.hashtag.HashtagResult;
import lambdas.story.StoryResult;
import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

public interface ITweetDAO {
    TweetPostResult postTweet(TweetPostRequest request);
    StoryResult getStory(String handle, int pageSize, String lastResult);
    HashtagResult getHashtag(String hashtag, int pageSize, String lastResult);
    TweetPostResult writeToTweet(TweetPostRequest request);
}
