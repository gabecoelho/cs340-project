package lambdas.sqs.writerLambda;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SQSEvent;
import com.google.gson.Gson;
import lambdas.dao.FeedDAO;
import lambdas.dao.TweetDAO;
import lambdas.dto.UserDTO;
import lambdas.sqs.PostToSQSRequest;
import lambdas.tweetPoster.TweetPostRequest;

import java.util.ArrayList;
import java.util.List;

public class SecondQueueWriteProcessor implements RequestHandler<SQSEvent, Void> {
    Gson gson = new Gson();
    FeedDAO feedDAO = new FeedDAO();
    TweetDAO tweetDAO = new TweetDAO();
    List<UserDTO> followersList;
    List<String> followerNames = new ArrayList<>();

    @Override
    public Void handleRequest(SQSEvent event, Context context) {
        for (SQSEvent.SQSMessage msg : event.getRecords()) {
            PostToSQSRequest request = gson.fromJson(msg.getBody(), PostToSQSRequest.class);
            TweetPostRequest tweetPostRequest = request.getTweetPostRequest();
            followersList = request.getFollowersList();
            for (UserDTO user : followersList) {
                followerNames.add(user.getUserHandle());
            }
            System.out.println("Sent request to DAO");
            tweetDAO.writeToTweet(tweetPostRequest);
            feedDAO.batchWriteToFeed(tweetPostRequest, followerNames);
        }
        return null;
    }

}