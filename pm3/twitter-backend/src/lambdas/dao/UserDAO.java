package lambdas.dao;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.services.dynamodbv2.document.*;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.QueryRequest;
import com.amazonaws.services.dynamodbv2.model.QueryResult;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import lambdas.follow.FollowRequest;
import lambdas.followers.FollowersResult;
import lambdas.dto.UserDTO;
import lambdas.follow.FollowResult;
import lambdas.following.FollowingResult;
import lambdas.follows.FollowsResult;
import lambdas.signup.SignupRequest;
import lambdas.signup.SignupResult;
import lambdas.tweetPoster.TweetPostResult;
import lambdas.unfollow.UnfollowRequest;
import lambdas.unfollow.UnfollowResult;
import lambdas.user.UserResult;

import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class UserDAO extends GeneralDAO {

    // User table
    private static final String UserTableName = "user";
    private static final String HandleAttr = "user_handle";
    private static final String NameAttr = "user_name";
    private static final String PhotoAttr = "user_photo";

    // Follow table
    private static final String FollowTableName = "follow";
    private static final String FollowIndexName = "follow-index";
    private static final String FollowerHandleAttr = "follower_handle";
    private static final String FollowerNameAttr = "follower_name";
    private static final String FollowerPhotoAttr = "follower_photo";
    private static final String FolloweeHandleAttr = "followee_handle";
    private static final String FolloweeNameAttr = "followee_name";
    private static final String FolloweePhotoAttr = "followee_photo";

    // S3
    private static final String bucketName = "340-twitter-bucket";

    ClientConfiguration configuration = new ClientConfiguration();


    AmazonS3 s3 = AmazonS3ClientBuilder
            .standard()
            .withRegion("us-west-2")
            .build();

    public SignupResult signUp(SignupRequest request) {
        Table table = dynamoDB.getTable(UserTableName);
        SignupResult result = new SignupResult();

        try {
            Item item = new Item()
                    .withPrimaryKey(HandleAttr, request.userDTO.getUserHandle())
                    .withString(NameAttr, request.userDTO.getUserName())
                    .withString(PhotoAttr, request.userDTO.getUserPicture());
            table.putItem(item);
            result.setSuccess(true);
        }
        catch (Exception e) {
            System.out.println("Could not add user to DB:" + e.toString());
            result.setSuccess(false);
        }
        return result;
    }

    public UserResult getUser(String handle) {
        Table table = dynamoDB.getTable(UserTableName);
        UserResult result = new UserResult();

        Item item = table.getItem("user_handle", handle);
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

    public FollowResult follow(FollowRequest request) {
        Table table = dynamoDB.getTable(FollowTableName);

        try {
            Item item = new Item()
                    .withPrimaryKey(FollowerHandleAttr, request.follower_handle, FolloweeHandleAttr, request.followee_handle)
                    .withString(FollowerNameAttr, request.follower_name)
                    .withString(FolloweeNameAttr, request.followee_name);
            table.putItem(item);
            System.out.println("Item " + item.toString() + " entered.");
        }
        catch (Exception e) {
            System.out.println("Could not follow user " + request.followee_handle + ": " + e.toString());
            return null;
        }

        return new FollowResult(
                request.follower_handle,
                request.followee_handle
        );
    }

    public UnfollowResult unfollow(UnfollowRequest request) {
        Table table = dynamoDB.getTable(FollowTableName);
        table.deleteItem(FollowerHandleAttr, request.follower_handle, FolloweeHandleAttr, request.followee_handle);
        return new UnfollowResult(request.follower_handle,request.followee_handle,false);
    }

    public FollowersResult getFollowers(String handle, int pageSize, String lastResult) {
        // Get all the users whose followee_handle equals the ${handle}
        FollowersResult result = new FollowersResult();

        Map<String, String> attrNames = new HashMap<String, String>();
        attrNames.put("#followee_handle", FolloweeHandleAttr);

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
            lastKey.put(FolloweeHandleAttr, new AttributeValue().withS(handle));
            lastKey.put(FollowerHandleAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(lastKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items) {
                UserDTO userDTO = new UserDTO(
                        item.get(FollowerHandleAttr).getS(),
                        item.get(FollowerNameAttr).getS(),
                        s3.getUrl(bucketName, item.get(FollowerHandleAttr).getS()).toExternalForm()
                );
                result.addValue(userDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(FollowerHandleAttr).getS());
        }
        return result;
    }

    public FollowingResult getFollowing(String handle, int pageSize, String lastResult) {
        // Get all the users whose follower_handle equals the ${handle}
        FollowingResult result = new FollowingResult();

        Map<String, String> attrNames = new HashMap<String, String>();
        attrNames.put("#follower_handle", FollowerHandleAttr);

        Map<String, AttributeValue> attrValues = new HashMap<>();
        attrValues.put(":follower_handle", new AttributeValue().withS(handle));

        QueryRequest queryRequest = new QueryRequest()
                .withTableName(FollowTableName)
                .withKeyConditionExpression("#follower_handle = :follower_handle")
                .withExpressionAttributeNames(attrNames)
                .withExpressionAttributeValues(attrValues)
                .withLimit(pageSize);

        if (isNonEmptyString(lastResult)) {
            Map<String, AttributeValue> startKey = new HashMap<>();
            startKey.put(FollowerHandleAttr, new AttributeValue().withS(handle));
            startKey.put(FolloweeHandleAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(startKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items){
                UserDTO userDTO = new UserDTO(
                        item.get(FolloweeHandleAttr).getS(),
                        item.get(FolloweeNameAttr).getS(),
                        s3.getUrl(bucketName, item.get(FollowerHandleAttr).getS()).toExternalForm()
                );
                result.addValue(userDTO);
            }
        }

        Map<String, AttributeValue> lastKey = queryResult.getLastEvaluatedKey();
        if (lastKey != null) {
            result.setLastKey(lastKey.get(FolloweeHandleAttr).getS());
        }
        return result;
    }

    public FollowsResult follows(String follower, String followee) {
        Table table = dynamoDB.getTable(FollowTableName);
        FollowsResult result = new FollowsResult();
        Item item = table.getItem(FollowerHandleAttr, follower, FolloweeHandleAttr, followee);

        result.follows = item != null;
        return result;
    }

    public String uploadProfilePicture(String handle, String base64String) {
        byte[] fileInBytes = Base64.getDecoder().decode(base64String.getBytes(StandardCharsets.UTF_8));
        InputStream fis = new ByteArrayInputStream(fileInBytes);

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(fileInBytes.length);
        metadata.setCacheControl("public, max-age=31536000");

        PutObjectRequest request = new PutObjectRequest(bucketName, handle, fis, metadata);

        s3.putObject(request);
        URL s3Url = s3.getUrl(bucketName, handle);

        return s3Url.toExternalForm();
    }
}
