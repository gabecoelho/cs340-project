package lambdas.user.story;

import lambdas.tweet.Tweet;

import java.util.ArrayList;
import java.util.List;

public class FeedRetriever {

    public Feed handleRequest() {

        List<Tweet> feed = new ArrayList<>();
        Tweet tweet = new Tweet(
                "someone", "hello, its me!!!", "https://image.businessinsider.com/5ba15375e361c01c008b5cf7?width=1100&format=jpeg&auto=webp", "2019-09-10", ""
        );

        Tweet secondTweet = new Tweet(
                "thirdperson", "Wish it was summer", "https://cdn.vox-cdn.com/thumbor/cjzNgDth8WN_0QTlA7OXz3oJa8c=/0x0:1033x689/1200x800/filters:focal(435x263:599x427)/cdn.vox-cdn.com/uploads/chorus_image/image/60393455/ive.0.png", "2019-09-10", "https://www.geo.tv/assets/uploads/updates/2019-09-24/248631_5324603_updates.jpg"
        );

        feed.add(tweet);
        feed.add(secondTweet);
        return new Feed(feed);
    }
}
