package lambdas.story;

import lambdas.dao.TweetDAO;

public class StoryRetriever {
    public StoryResult handleRequest(StoryRequest storyRequest) {
        return new TweetDAO().getStory(storyRequest.handle, storyRequest.pageSize, storyRequest.lastResult);
    }
}
