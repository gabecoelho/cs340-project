package lambdas.sqs.batchLambda;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SQSEvent;
import com.amazonaws.services.sqs.model.SendMessageBatchRequest;
import com.google.gson.Gson;
import lambdas.dao.UserDAO;
import lambdas.dto.UserDTO;
import lambdas.followers.FollowersResult;
import lambdas.services.SQSFeedService;
import lambdas.sqs.PostToSQSRequest;
import lambdas.tweetPoster.TweetPostRequest;

import java.util.ArrayList;
import java.util.List;

public class FirstQueueBatchProcessor implements RequestHandler<SQSEvent, Void> {
    Gson gson = new Gson();
    UserDAO userDAO = new UserDAO();
    SQSFeedService sqsFeedService = new SQSFeedService();
    PostToSQSRequest postToSQSRequest = new PostToSQSRequest();

    @Override
    public Void handleRequest(SQSEvent event, Context context) {
        for (SQSEvent.SQSMessage msg : event.getRecords()) {
            System.out.println(msg.toString());

            // Step 1 - Receive and deserialize request
            TweetPostRequest tweetPostRequest = gson.fromJson(msg.getBody(), TweetPostRequest.class);

            // Step 2 - Get followers
            FollowersResult followersResult = userDAO.getFollowers(tweetPostRequest.tweetDTO.getUserHandle(), 10001, "");

            // Step 3 - Separate all of the followers into batches
            int count = 0;
            while (count < followersResult.getFollowers().size()) {
                int start = count;
                int end = Math.min(start + 450, followersResult.getFollowers().size());

                List<UserDTO> followersSublist = followersResult.getFollowers().subList(start, end);

                postToSQSRequest.setFollowersList(followersSublist);
                postToSQSRequest.setTweetPostRequest(tweetPostRequest);

                count = end;
                sqsFeedService.postTweetToSecondSQS(postToSQSRequest);
            }
        }
        return null;
    }
}