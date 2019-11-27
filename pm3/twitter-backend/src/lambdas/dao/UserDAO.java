package lambdas.dao;

import com.amazonaws.services.dynamodbv2.document.*;
import lambdas.follow.FollowResult;

public class UserDAO extends GeneralDAO {
    public String userHandle;
    public String userName;
    public String userPicture;

    private static final String TableName = "user";

    public UserDAO() {
    }

    public UserDAO(String userHandle, String userName, String userPicture) {
        this.userHandle = userHandle;
        this.userName = userName;
        this.userPicture = userPicture;
    }

    public FollowResult follow(String follower_id, String followee_id) {
        Table table = dynamoDB.getTable(TableName);

        try {
            Item item = new Item().withPrimaryKey("follower_id", follower_id, "followee_id", followee_id);
            table.putItem(item);
            System.out.println("Item " + item.toString() + " entered.");
        }
        catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }

        return new FollowResult(
                follower_id,
                followee_id
        );
    }

    public String getUserHandle() {
        return userHandle;
    }

    public void setUserHandle(String userHandle) {
        this.userHandle = userHandle;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPicture() {
        return userPicture;
    }

    public void setUserPicture(String userPicture) {
        this.userPicture = userPicture;
    }
}
