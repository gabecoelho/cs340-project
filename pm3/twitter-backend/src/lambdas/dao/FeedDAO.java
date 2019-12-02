package lambdas.dao;

import com.amazonaws.services.dynamodbv2.model.*;
import lambdas.dto.FeedDTO;
import lambdas.dto.TweetDTO;
import lambdas.feed.FeedResult;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedDAO extends GeneralDAO {

    private static final String TableName = "feed";
    private static final String AttachmentAttr = "attachment";
    private static final String MessageAttr = "message";
    private static final String TimestampAttr = "timestamp";
    private static final String TweetAuthorAttr = "tweet_author_handle";
    private static final String HandleAttr = "user_handle";
    private static final String NameAttr = "tweet_author_name";
    private static final String PhotoAttr = "user_photo";

    public FeedResult getFeed(String handle, int pageSize, String lastItem) {
        // TODO: Show me the tweets from ONLY users I follow:
        // TODO: Sort the tweets by timestamp

        if (pageSize == 0) {
            pageSize = 10;
        }

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

        if (isNonEmptyString(lastItem)) {
            Map<String, AttributeValue> startKey = new HashMap<>();
            startKey.put(HandleAttr, new AttributeValue().withS(handle));
            startKey.put(TimestampAttr, new AttributeValue().withS(lastItem));

            queryRequest = queryRequest.withExclusiveStartKey(startKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items) {
                TweetDTO tweetDTO = new TweetDTO(
                        item.get(TweetAuthorAttr).getS(),
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
}
