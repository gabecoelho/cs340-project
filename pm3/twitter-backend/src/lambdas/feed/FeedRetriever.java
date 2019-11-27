package lambdas.feed;

import lambdas.dao.FeedDAO;

public class FeedRetriever {

    public FeedResult handleRequest(FeedRequest feedRequest) {
        FeedResult feedResult = new FeedResult();
        FeedDAO feedDAO = new FeedDAO();

        return feedDAO.getFeed(feedRequest.handle, feedRequest.pageSize, "");
    }
}
