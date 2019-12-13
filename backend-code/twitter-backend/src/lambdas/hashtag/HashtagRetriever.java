package lambdas.hashtag;

import lambdas.dao.TweetDAO;

public class HashtagRetriever {
    public HashtagResult handleRequest(HashtagRequest request) {
        return new TweetDAO().getHashtag(request.hashtag, request.pageSize, request.lastResult);
    }
}
