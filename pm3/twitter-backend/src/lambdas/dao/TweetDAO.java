package lambdas.dao;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.*;

import java.text.SimpleDateFormat;
import java.util.*;

import com.amazonaws.services.dynamodbv2.model.*;

import lambdas.dto.TweetDTO;
import lambdas.dto.UserDTO;
import lambdas.feed.AddToFeedRequest;
import lambdas.followers.FollowersResult;
import lambdas.hashtag.HashtagResult;
import lambdas.story.StoryResult;
import lambdas.tweetPoster.TweetPostRequest;
import lambdas.tweetPoster.TweetPostResult;

public class TweetDAO extends GeneralDAO {

    // Feed table information
    private static final String FeedTableName = "feed";
    private static final String TweetAuthorHandleAttr = "tweet_author_handle";
    private static final String TweetAuthorNameAttr = "tweet_author_name";
    private static final String TweetAuthorPhoto = "tweet_author_photo";

    // Tweet table information
    private static final String TableName = "tweet";
    private static final String HandleAttr = "user_handle";
    private static final String TimestampAttr = "timestamp";
    private static final String AttachmentAttr = "attachment";
    private static final String MessageAttr = "message";
    private static final String NameAttr = "user_name";
    private static final String PhotoAttr = "user_photo";

    private String timestamp =  new SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'").format(new Date());

    public TweetPostResult postTweet(TweetPostRequest request) {

        /*
          The flow is:
          1. Add to the tweet table
          2. Get list of followers back from follows table
          3. Append each follower_handle to the feed table with the tweet information
         */

        // Step 1
        Table table = dynamoDB.getTable(TableName);
        TweetPostResult result = new TweetPostResult();
        UserDAO userDAO = new UserDAO();
        FeedDAO feedDAO = new FeedDAO();

        try {
            Item item = new Item()
                    .withPrimaryKey(HandleAttr, request.tweetDTO.getUserHandle(), TimestampAttr, timestamp)
                    .withString(MessageAttr, request.tweetDTO.getMessage())
                    .withString(NameAttr, request.tweetDTO.getUserName())
                    .withString(PhotoAttr, request.tweetDTO.getUserPhoto());
            if (request.tweetDTO.getAttachment() != null) {
                item.withString(AttachmentAttr, request.tweetDTO.getAttachment());
            }
            table.putItem(item);
            result.setSuccess(true);
        }
        catch (Exception e) {
            System.out.println("Could not add item to DB:" + e.toString());
            result.setSuccess(false);
        }
         // Step 2 - get followers
        FollowersResult followersResult = userDAO.getFollowers(request.tweetDTO.userHandle, 25, "");

        // Step 3 - Append to feed
        if (followersResult != null) {
            for (UserDTO user : followersResult.followers) {
                // Build request
                AddToFeedRequest addToFeedRequest = new AddToFeedRequest();
                addToFeedRequest.user_handle = user.getUserHandle();
                addToFeedRequest.tweet_author_handle = request.tweetDTO.userHandle;
                addToFeedRequest.tweet_author_name = request.tweetDTO.userName;
                addToFeedRequest.tweet_author_photo = request.tweetDTO.userPhoto;
                addToFeedRequest.message = request.tweetDTO.message;
                if (request.tweetDTO.attachment != null)
                    addToFeedRequest.attachment = request.tweetDTO.attachment;
                else
                    addToFeedRequest.attachment = "null";
                addToFeedRequest.timestamp = request.tweetDTO.timestamp;

                // Add to feed
                feedDAO.addToFeed(addToFeedRequest);
            }
        }

        return result;
    }

    public StoryResult getStory(String handle, int pageSize, String lastResult) {
        StoryResult result = new StoryResult();

        Map<String, String> attrNames = new HashMap<String, String>();
        attrNames.put("#user_handle", HandleAttr);

        Map<String, AttributeValue> attrValues = new HashMap<>();
        attrValues.put(":user_handle", new AttributeValue().withS(handle));

        QueryRequest queryRequest = new QueryRequest()
                .withTableName(TableName)
                .withKeyConditionExpression("#user_handle = :user_handle")
                .withExpressionAttributeNames(attrNames)
                .withExpressionAttributeValues(attrValues)
                .withLimit(pageSize);

        if (isNonEmptyString(lastResult)) {
            Map<String, AttributeValue> startKey = new HashMap<>();
            startKey.put(HandleAttr, new AttributeValue().withS(handle));
            startKey.put(TimestampAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(startKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items){
                TweetDTO tweetDTO = new TweetDTO(
                        item.get(HandleAttr).getS(),
                        item.get(NameAttr).getS(),
                        item.get(PhotoAttr).getS(),
                        item.get(MessageAttr).getS(),
                        item.get(AttachmentAttr).getS(),
                        item.get(TimestampAttr).getS()
                );
                result.addValue(tweetDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(TimestampAttr).getS());
        }

        return result;
    }

    public HashtagResult getHashtag(String hashtag, int pageSize, String lastResult) {
        hashtag = "#"+hashtag;
        Map<String, AttributeValue> lastKeyEvaluated = null;
        HashtagResult result = new HashtagResult();

        Map<String, String> attrNames = new HashMap<>();
        attrNames.put("#message", MessageAttr);

        Map<String, AttributeValue> attrValues = new HashMap<>();
        attrValues.put(":hashtag", new AttributeValue().withS(hashtag));

        do {
            ScanRequest scanRequest = new ScanRequest()
                    .withTableName(TableName)
                    .withExpressionAttributeNames(attrNames)
                    .withExpressionAttributeValues(attrValues)
                    .withLimit(pageSize)
                    .withFilterExpression("contains(#message, :hashtag)")
                    .withExclusiveStartKey(lastKeyEvaluated);

            ScanResult scanResult = amazonDynamoDB.scan(scanRequest);
            List<Map<String, AttributeValue>> items = scanResult.getItems();
                    if (items != null) {
            for (Map<String, AttributeValue> item : items){
                TweetDTO tweetDTO = new TweetDTO(
                        item.get(HandleAttr).getS(),
                        item.get(NameAttr).getS(),
                        item.get(PhotoAttr).getS(),
                        item.get(MessageAttr).getS(),
                        item.get(AttachmentAttr).getS(),
                        item.get(TimestampAttr).getS()
                );
                result.addValue(tweetDTO);
            }
        }
            lastKeyEvaluated = scanResult.getLastEvaluatedKey();
        } while (lastKeyEvaluated != null);

        return result;

//        HashtagResult result = new HashtagResult();
//
//        Map<String, String> attrNames = new HashMap<>();
//        attrNames.put("#message", MessageAttr);
//
//        Map<String, AttributeValue> attrValues = new HashMap<>();
//        attrValues.put(":hashtag", new AttributeValue().withS(hashtag));
//
//        QueryRequest queryRequest = new QueryRequest()
//                .withTableName(TableName)
////                .withIndexName(TweetTableIndex)
//                .withFilterExpression("contains(#message, :hashtag)")
//                .withKeyConditionExpression("#message = :hashtag")
//                .withExpressionAttributeNames(attrNames)
//                .withExpressionAttributeValues(attrValues)
//                .withLimit(pageSize);
//
//        if (isNonEmptyString(lastResult)) {
//            Map<String, AttributeValue> startKey = new HashMap<>();
//            startKey.put(MessageAttr, new AttributeValue().withS(hashtag));
//            startKey.put(TimestampAttr, new AttributeValue().withS(lastResult));
//
//            queryRequest = queryRequest.withExclusiveStartKey(startKey);
//        }
//
//        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
//        List<Map<String, AttributeValue>> items = queryResult.getItems();
//        if (items != null) {
//            for (Map<String, AttributeValue> item : items){
//                TweetDTO tweetDTO = new TweetDTO(
//                        item.get(HandleAttr).getS(),
//                        item.get(NameAttr).getS(),
//                        item.get(PhotoAttr).getS(),
//                        item.get(MessageAttr).getS(),
//                        item.get(AttachmentAttr).getS(),
//                        item.get(TimestampAttr).getS()
//                );
//                result.addValue(tweetDTO);
//            }
//        }
//
//        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
//        if (lastKey != null) {
//            result.setLastKey(lastKey.get(TimestampAttr).getS());
//        }
//
//        return result;
    }
}
