package lambdas.sqs;

import lambdas.dto.UserDTO;
import lambdas.tweetPoster.TweetPostRequest;

import java.util.List;

public class PostToSQSRequest {
    public List<UserDTO> followersList;
    public TweetPostRequest tweetPostRequest;

    public List<UserDTO> getFollowersList() {
        return followersList;
    }

    public void setFollowersList(List<UserDTO> followersList) {
        this.followersList = followersList;
    }

    public TweetPostRequest getTweetPostRequest() {
        return tweetPostRequest;
    }

    public void setTweetPostRequest(TweetPostRequest tweetPostRequest) {
        this.tweetPostRequest = tweetPostRequest;
    }
}
