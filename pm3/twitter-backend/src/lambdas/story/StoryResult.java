package lambdas.story;

import lambdas.dto.TweetDTO;

import java.util.List;

public class StoryResult {

    private List<TweetDTO> story;
    private String lastKey;

    public List<TweetDTO> getStory() {
        return story;
    }
    public void setStory(List<TweetDTO> story) {
        this.story = story;
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
        story.add(v);
    }
}
