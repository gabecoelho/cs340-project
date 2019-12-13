package lambdas.services;

import lambdas.dao.TweetDAO;
import lambdas.hashtag.HashtagResult;
import lambdas.story.StoryResult;
import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

public class TweetService {

    TweetDAO tweetDAO = new TweetDAO();

    public TweetPostResult postTweet(TweetPostRequest request) {
        return tweetDAO.postTweet(request);
    }

    public StoryResult getStory(String handle, int pageSize, String lastResult) {
        return tweetDAO.getStory(handle, pageSize, lastResult);
    }

    public HashtagResult getHashtag(String hashtag, int pageSize, String lastResult) {
        return tweetDAO.getHashtag(hashtag, pageSize, lastResult);
    }
}
