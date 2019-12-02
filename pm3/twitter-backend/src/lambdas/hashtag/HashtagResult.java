package lambdas.hashtag;

import lambdas.dto.TweetDTO;

import java.util.HashSet;
import java.util.Set;

public class HashtagResult {
    public Set<TweetDTO> hashtags = new HashSet<>();

    public  String lastKey;

    public Set<TweetDTO> getHashtags() {
        return hashtags;
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
        hashtags.add(v);
    }
}
