package lambdas.dao;

import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.model.*;
import lambdas.dto.FeedDTO;
import lambdas.dto.TweetDTO;
import lambdas.feed.AddToFeedRequest;
import lambdas.feed.FeedResult;
import lambdas.tweetPoster.TweetPostResult;

import java.text.AttributedString;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedDAO extends GeneralDAO {

    private static final String TableName = "feed";
    private static final String AttachmentAttr = "attachment";
    private static final String MessageAttr = "message";
    private static final String TimestampAttr = "timestamp";
    private static final String TweetAuthorHandleAttr = "tweet_author_handle";
    private static final String TweetAuthorNameAttr = "tweet_author_name";
    private static final String TweetAuthorPhoto = "tweet_author_photo";
    private static final String HandleAttr = "user_handle";

    public FeedResult getFeed(String handle, int pageSize, String lastResult) {
        // TODO: Sort the tweets by timestamp here or in client

        FeedResult result = new FeedResult();

        Map<String, String> attrNames;
        attrNames = new HashMap<String, String>();
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
            for (Map<String, AttributeValue> item : items) {
                TweetDTO tweetDTO = new TweetDTO(
                        item.get(TweetAuthorHandleAttr).getS(),
                        item.get(TweetAuthorNameAttr).getS(),
                        item.get(TweetAuthorPhoto).getS(),
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

    public void addToFeed(AddToFeedRequest request) {
        Table table = dynamoDB.getTable(TableName);
        try {
            Item item = new Item()
                    .withPrimaryKey(HandleAttr, request.user_handle)
                    .withString(TimestampAttr, request.timestamp)
                    .withString(MessageAttr, request.message)
                    .withString(TweetAuthorHandleAttr, request.tweet_author_handle)
                    .withString(TweetAuthorNameAttr, request.tweet_author_name)
                    .withString(TweetAuthorPhoto, request.tweet_author_photo)
                    .withString(AttachmentAttr, request.attachment);

            table.putItem(item);
        }
        catch (Exception e) {
            System.out.println("Could not add item to DB:" + e.toString());
        }
    }
}
