package lambdas.tweetPoster;

import lambdas.dao.TweetDAO;

public class TweetPoster {
    public TweetPostResult handleRequest(TweetPostRequest request) {
        return new TweetDAO().postTweet(request.tweetDTO);
    }
}
