package lambdas.services;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.*;
import lambdas.sqs.PostToSQSRequest;
import lambdas.tweetPoster.TweetPostRequest;
import com.google.gson.Gson;

import java.util.List;

public class SQSFeedService implements IFeedService {

    String firstQueueUrl = "https://sqs.us-west-2.amazonaws.com/463662460683/first-queue";
    String secondQueueUrl = "https://sqs.us-west-2.amazonaws.com/463662460683/second-queue";
    AmazonSQS sqs = AmazonSQSClientBuilder.defaultClient();
    Gson gson = new Gson();

    @Override
    public void postTweetToFirstSQS(TweetPostRequest request) {
        String serializedRequestMessage = gson.toJson(request);
        SendMessageRequest sendMessageRequest = new SendMessageRequest()
                .withQueueUrl(firstQueueUrl)
                .withMessageBody(serializedRequestMessage)
                .withDelaySeconds(1);

        SendMessageResult sendMessageResult = sqs.sendMessage(sendMessageRequest);

        String msgId = sendMessageResult.getMessageId();
        System.out.println("1st Queue: Message ID: " + msgId);
    }

    @Override
    public void postTweetToSecondSQS(PostToSQSRequest request) {

        String serializedRequestMessage = gson.toJson(request);
        SendMessageRequest sendMessageRequest = new SendMessageRequest()
                .withQueueUrl(secondQueueUrl)
                .withMessageBody(serializedRequestMessage)
                .withDelaySeconds(2);

        SendMessageResult sendMessageResult = sqs.sendMessage(sendMessageRequest);

        String msgId = sendMessageResult.getMessageId();
        System.out.println("2nd Queue: Message ID: " + msgId);

    }

}
