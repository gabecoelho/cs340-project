package lambdas.dao;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.*;

import java.text.SimpleDateFormat;
import java.util.*;

import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.QueryRequest;
import com.amazonaws.services.dynamodbv2.model.QueryResult;

import lambdas.dto.TweetDTO;
import lambdas.story.StoryResult;

public class TweetDAO extends GeneralDAO {

    private static final String TableName = "tweet";
    private static final String HandleAttr = "user_handle";
    private static final String TimestampAttr = "timestamp";
    private static final String AttachmentAttr = "attachment";
    private static final String MessageAttr = "message";
    private static final String NameAttr = "user_name";
    private static final String PhotoAttr = "user_photo";

    private String timestamp =  new SimpleDateFormat("yyyyMMddHHmmssX").format(new Date());

    public TweetDAO() {}

    public boolean postTweet(TweetDTO tweetDTO) {
        Table table = dynamoDB.getTable(TableName);

        try {
            Item item = new Item()
                    .withPrimaryKey(HandleAttr, tweetDTO.getUserHandle(), TimestampAttr, timestamp)
                    .withString(MessageAttr, tweetDTO.getMessage())
                    .withString(NameAttr, tweetDTO.getUserName())
                    .withString(PhotoAttr, tweetDTO.getUserPhoto());
            if (tweetDTO.getAttachment() != null) {
                item.withString(AttachmentAttr, tweetDTO.getAttachment());
            }
            table.putItem(item);
            return true;
        }
        catch (Exception e) {
            System.out.println("Could not add item to DB:" + e.toString());
            return false;
        }
    }

    public StoryResult getStory(String handle, int pageSize, String lastResult) {
        List<TweetDTO> story = new ArrayList<>();
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
                story.add(tweetDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(TimestampAttr).getS());
        }

        result.setStory(story);
        return result;
    }
}
