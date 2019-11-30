package lambdas.dao;

import com.amazonaws.services.dynamodbv2.document.*;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.QueryRequest;
import com.amazonaws.services.dynamodbv2.model.QueryResult;

import com.amazonaws.services.s3.model.PutObjectRequest;

import lambdas.followers.FollowersResult;
import lambdas.dto.UserDTO;
import lambdas.follow.FollowResult;
import lambdas.following.FollowingResult;
import lambdas.unfollow.UnfollowResult;
import lambdas.user.UserResult;

import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class UserDAO extends GeneralDAO {

    private static final String UserTableName = "user";
    private static final String FollowTableName = "follow";
    private static final String FollowIndexName = "follow-index";
    private static final String HandleAttr = "user_handle";
    private static final String NameAttr = "user_name";
    private static final String PhotoAttr = "user_photo";
    private static final String FollowerAttr = "follower_handle";
    private static final String FolloweeAttr = "followee_handle";
    private static final String bucketName = "340-twitter-bucket";

    public UserResult getUser(String handle) {
        Table table = dynamoDB.getTable(UserTableName);
        UserResult result = new UserResult();

        Item item = table.getItem(HandleAttr, handle);
        if (item != null) {
            UserDTO user = new UserDTO(
                    item.getString(HandleAttr),
                    item.getString(NameAttr),
                    item.getString(PhotoAttr)
            );
            result.setUser(user);
        }
        return result;
    }

    public FollowResult follow(String follower_handle, String followee_handle) {
        Table table = dynamoDB.getTable(UserTableName);

        try {
            Item item = new Item().withPrimaryKey(FollowerAttr, follower_handle, FolloweeAttr, followee_handle);
            table.putItem(item);
            System.out.println("Item " + item.toString() + " entered.");
        }
        catch (Exception e) {
            System.out.println("Could not follow user " + followee_handle + ": " + e.toString());
            return null;
        }

        return new FollowResult(
                follower_handle,
                followee_handle
        );
    }

    public UnfollowResult unfollow(String follower_handle, String followee_handle) {
        Table table = dynamoDB.getTable(UserTableName);
        table.deleteItem(FollowerAttr, follower_handle, FolloweeAttr, followee_handle);
        return new UnfollowResult(follower_handle,followee_handle,false);
    }

    public FollowersResult getFollowers(String handle, int pageSize, String lastResult) {
        // Get all the users whose followee_handle equals the ${handle}
        FollowersResult result = new FollowersResult();

        Map<String, String> attrNames = new HashMap<String, String>();
        attrNames.put("#followee_handle", HandleAttr);

        Map<String, AttributeValue> attrValues = new HashMap<>();
        attrValues.put(":followee_handle", new AttributeValue().withS(handle));

        QueryRequest queryRequest = new QueryRequest()
                .withTableName(FollowTableName)
                .withIndexName(FollowIndexName)
                .withKeyConditionExpression("#followee_handle = :followee_handle")
                .withExpressionAttributeNames(attrNames)
                .withExpressionAttributeValues(attrValues)
                .withLimit(pageSize);

        if (isNonEmptyString(lastResult)) {
            Map<String, AttributeValue> lastKey = new HashMap<>();
            lastKey.put(FolloweeAttr, new AttributeValue().withS(handle));
            lastKey.put(FollowerAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(lastKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items) {
                UserDTO userDTO = new UserDTO(
                        item.get(HandleAttr).getS(),
                        item.get(NameAttr).getS(),
                        item.get(PhotoAttr).getS()
                );
                result.addValue(userDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(FollowerAttr).getS());
        }
        return result;
    }

    public FollowingResult getFollowing(String handle, int pageSize, String lastResult) {
        // Get all the users whose following_handle equals the ${handle}
        FollowingResult result = new FollowingResult();

        Map<String, String> attrNames = new HashMap<String, String>();
        attrNames.put("#follower_handle", HandleAttr);

        Map<String, AttributeValue> attrValues = new HashMap<>();
        attrValues.put(":follower_handle", new AttributeValue().withS(handle));

        QueryRequest queryRequest = new QueryRequest()
                .withTableName(FollowTableName)
                .withKeyConditionExpression("#follower_handle = :follower_handle")
                .withExpressionAttributeNames(attrNames)
                .withExpressionAttributeValues(attrValues)
                .withLimit(pageSize);

        if (isNonEmptyString(lastResult)) {
            Map<String, AttributeValue> lastKey = new HashMap<>();
            lastKey.put(FollowerAttr, new AttributeValue().withS(handle));
            lastKey.put(FolloweeAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(lastKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items){
                UserDTO userDTO = new UserDTO(
                        item.get(HandleAttr).getS(),
                        item.get(NameAttr).getS(),
                        item.get(PhotoAttr).getS()
                );
                result.addValue(userDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(FolloweeAttr).getS());
        }
        return result;
    }

    public boolean follows(String follower, String followee) {
        Table table = dynamoDB.getTable(FollowTableName);
        Item item = table.getItem(FollowerAttr, follower, FolloweeAttr, followee);
        return item != null;
    }

    public String uploadProfilePicture(String base64String) {
        String fileTitle = UUID.randomUUID().toString();

        PutObjectRequest request = new PutObjectRequest(bucketName, fileTitle, base64String);
        s3Client.putObject(request);
        URL s3Url = s3Client.getUrl(bucketName, fileTitle);

        // Change user's profile picture in User's table AND Cognito user pool:
        // Since this is method should be called before the Cognito SIGN-UP,
        // it should return a String with the URL of the picture and
        // then it should be sent in the Cognito request, as well as to our own user table.
        System.out.println("S3 url is " + s3Url.toExternalForm());
        return s3Url.toExternalForm();
    }

    public String editProfilePicture(String handle, String base64String) {
        String fileTitle = UUID.randomUUID().toString();

        // Upload a file as a new object with ContentType and title specified.
        PutObjectRequest request = new PutObjectRequest(bucketName, fileTitle, base64String);
        s3Client.putObject(request);
        URL s3Url = s3Client.getUrl(bucketName, fileTitle);
        System.out.println("S3 url is " + s3Url.toExternalForm());

        // Change user's profile picture in User's table AND Cognito user pool:
        // it should update the users table with the new picture URL of the picture and
        // maybe also in the Cognito user pool.
        updateUsersTableWithNewPicture(handle, s3Url.toExternalForm());
        return s3Url.toExternalForm();
    }

    private void updateUsersTableWithNewPicture(String handle, String url) {
        Table table = dynamoDB.getTable(UserTableName);

        try {
            Map<String, String> attrNames = new HashMap<String, String>();
            Map<String, Object> attrValues = new HashMap<String, Object>();

            attrNames.put("#user_photo", PhotoAttr);
            attrValues.put(":user_photo", url);

            table.updateItem(HandleAttr, handle, "set #user_handle = " + handle + " with new photo: :user_photo", attrNames, attrValues);
        }
        catch (Exception e) {
            System.out.println("There was a problem updating users table with new picture: " + e.toString());
        }
    }

}
