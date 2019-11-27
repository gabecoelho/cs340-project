package lambdas.story;

import lambdas.dao.TweetDAO;

import java.util.ArrayList;
import java.util.List;

public class StoryRetriever {
    public Story handleRequest() {
        List<TweetDAO> feed = new ArrayList<>();
        TweetDAO tweet = new TweetDAO(
                "someone", "Some One","https://image.businessinsider.com/5ba15375e361c01c008b5cf7?width=1100&format=jpeg&auto=webp", "hello, its me!!!", "", "2019-09-10"
        );

        TweetDAO secondTweet = new TweetDAO(
                "thirdperson", "Third Person", "https://cdn.vox-cdn.com/thumbor/cjzNgDth8WN_0QTlA7OXz3oJa8c=/0x0:1033x689/1200x800/filters:focal(435x263:599x427)/cdn.vox-cdn.com/uploads/chorus_image/image/60393455/ive.0.png", "Wish it was summer", "https://www.geo.tv/assets/uploads/updates/2019-09-24/248631_5324603_updates.jpg", "2019-09-10"
        );

        feed.add(tweet);
        feed.add(secondTweet);
        return new Story(feed);
    }
}
