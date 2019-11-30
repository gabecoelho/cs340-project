package lambdas.feed;

import lambdas.dao.FeedDAO;

public class FeedRetriever {
    public FeedResult handleRequest(FeedRequest feedRequest) {
        return new FeedDAO().getFeed(feedRequest.handle, feedRequest.pageSize, feedRequest.lastItem);
    }
}
