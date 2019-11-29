package lambdas.dto;

import java.util.List;

public class FeedDTO {

    private List<TweetDTO> feed;

    public FeedDTO(List<TweetDTO> feed) {
        this.feed = feed;
    }

    public List<TweetDTO> getFeed() {
        return feed;
    }

    public void setFeed(List<TweetDTO> feed) {
        this.feed = feed;
    }
}
