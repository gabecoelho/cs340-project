package lambdas.feed;

import lambdas.dao.FeedDAO;

public class FeedRetriever {

    public FeedResult handleRequest(FeedRequest feedRequest) {
        FeedDAO feedDAO = new FeedDAO();
        return feedDAO.getFeed(feedRequest.handle, feedRequest.pageSize, feedRequest.lastItem);
    }
}
