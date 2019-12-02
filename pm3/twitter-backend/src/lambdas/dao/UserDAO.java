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
import lambdas.unfollow.UnfollowResult;
import lambdas.user.UserResult;

import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
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
                    .withString(FollowerPhotoAttr, request.follower_photo)
                    .withString(FolloweeNameAttr, request.followee_name)
                    .withString(FolloweePhotoAttr, request.followee_photo);
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

    public UnfollowResult unfollow(String follower_handle, String followee_handle) {
        Table table = dynamoDB.getTable(UserTableName);
        table.deleteItem(FollowerHandleAttr, follower_handle, FolloweeHandleAttr, followee_handle);
        return new UnfollowResult(follower_handle,followee_handle,false);
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
                        item.get(FollowerPhotoAttr).getS()
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
        // Get all the users whose following_handle equals the ${handle}
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
            Map<String, AttributeValue> lastKey = new HashMap<>();
            lastKey.put(FollowerHandleAttr, new AttributeValue().withS(handle));
            lastKey.put(FolloweeHandleAttr, new AttributeValue().withS(lastResult));

            queryRequest = queryRequest.withExclusiveStartKey(lastKey);
        }

        QueryResult queryResult = amazonDynamoDB.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResult.getItems();
        if (items != null) {
            for (Map<String, AttributeValue> item : items){
                UserDTO userDTO = new UserDTO(
                        item.get(FolloweeHandleAttr).getS(),
                        item.get(FolloweeNameAttr).getS(),
                        item.get(FolloweePhotoAttr).getS()
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

    public String uploadProfilePicture(String base64String) {
        String fileTitle = UUID.randomUUID().toString();
        byte[] fileInBytes = Base64.getDecoder().decode(base64String.getBytes(StandardCharsets.UTF_8));
        InputStream fis = new ByteArrayInputStream(fileInBytes);
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(fileInBytes.length);
        metadata.setCacheControl("public, max-age=31536000");

        PutObjectRequest request = new PutObjectRequest(bucketName, fileTitle, fis, metadata);

        s3.putObject(request);
        URL s3Url = s3.getUrl(bucketName, fileTitle);

        // Change user's profile picture in User's table AND Cognito user pool:
        // Since this is method should be called before the Cognito SIGN-UP,
        // it should return a String with the URL of the picture and
        // then it should be sent in the Cognito request, as well as to our own user table.
        System.out.println("S3 url is " + s3Url.toExternalForm());
        return s3Url.toExternalForm();
    }

    public String editProfilePicture(String handle, String base64String) {
        String fileTitle = UUID.randomUUID().toString();
        byte[] fileInBytes = Base64.getDecoder().decode(base64String.getBytes(StandardCharsets.UTF_8));
        InputStream fis = new ByteArrayInputStream(fileInBytes);
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(fileInBytes.length);
        metadata.setCacheControl("public, max-age=31536000");

        PutObjectRequest request = new PutObjectRequest(bucketName, fileTitle, fis, metadata);

        s3.putObject(request);
        URL s3Url = s3.getUrl(bucketName, fileTitle);

        // TODO: Change user's profile picture in User's table AND Cognito user pool:
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
            attrValues.put(":photo", url);

            table.updateItem(HandleAttr, handle, "set #user_photo = :photo", attrNames, attrValues);
        }
        catch (Exception e) {
            System.out.println("There was a problem updating users table with new picture: " + e.toString());
        }
    }

}
