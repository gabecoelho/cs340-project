package lambdas.feed;

import java.util.List;

public class FeedResult {

    private List<Object> feed;
    private String lastKey;

    public List<Object> getFeed() {
        return feed;
    }
    public void setFeed(List<Object> feed) {
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
    public void addValue(Object v) {
        feed.add(v);
    }
}
