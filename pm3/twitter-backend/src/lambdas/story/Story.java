package lambdas.story;

import lambdas.dao.TweetDAO;

import java.util.List;

public class Story {
    public List<TweetDAO> story;

    public Story(List<TweetDAO> story) {
        this.story = story;
    }
}
