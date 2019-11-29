package lambdas.feed;

import lambdas.dto.TweetDTO;

import java.util.List;

public class FeedResult {

    private List<TweetDTO> feed;
    private String lastKey;

    public List<TweetDTO> getFeed() {
        return feed;
    }
    public void setFeed(List<TweetDTO> feed) {
        this.feed = feed;
    }
    public String getLastKey() {
        return lastKey;
    }
    public void setLastKey(String value) {
        lastKey = value;
    }
    public boolean hasLastKey() {
        return (lastKey != null && lastKey.length() > 0);
    }
    public void addValue(TweetDTO v) {
        feed.add(v);
    }
}
