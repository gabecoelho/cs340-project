package lambdas.dao;

import com.amazonaws.services.dynamodbv2.model.*;
import lambdas.feed.FeedResult;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedDAO extends GeneralDAO {

    private static final String TableName = "feed";
    private static final String HandleAttr = "user_handle";
    private static final String TimestampAttr = "timestamp";

    public FeedResult getFeed(String handle, int pageSize, String lastItem) {
        FeedResult result = new FeedResult();

        Map<String, String> attrNames;
        attrNames = new HashMap<String, String>();
        attrNames.put("#user_handle", HandleAttr);
//        attrNames.put("#timestamp", TimestampAttr);

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
            // TODO: make sure this is correct
            startKey.put(TimestampAttr, new AttributeValue().withS(lastItem));
//            startKey.put(LocationAttr, new AttributeValue().withS(lastItem));

            queryRequest = queryRequest.withExclusiveStartKey(startKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items) {
//                TweetDAO tweetDAO = item.get(HandleAttr).getS();
                String timestamp = item.get(TimestampAttr).getS();
                result.addValue(timestamp);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(TimestampAttr).getS());
        }


        return result;
    }
}
