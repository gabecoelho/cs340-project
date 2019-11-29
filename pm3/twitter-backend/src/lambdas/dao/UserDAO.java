package lambdas.dao;

import com.amazonaws.services.dynamodbv2.document.*;
import lambdas.followers.FollowersResult;
import lambdas.dto.UserDTO;
import lambdas.follow.FollowResult;
import lambdas.following.FollowingResult;
import lambdas.follows.FollowsResult;
import lambdas.picture.PictureUploadResult;
import lambdas.unfollow.UnfollowResult;

public class UserDAO extends GeneralDAO {

    private static final String TableName = "user";
    private static final String HandleAttr = "user_handle";
    private static final String NameAttr = "user_name";
    private static final String PhotoAttr = "user_photo";

    public UserDAO() {}

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

    public UnfollowResult unfollow() { return new UnfollowResult("","",false);}
    public FollowersResult getFollowers(String handle) { return new FollowersResult();}
    public FollowingResult getFollowing(String handle) { return new FollowingResult(null);}
    public FollowsResult follows(String follower, String followee){return new FollowsResult();}
    public PictureUploadResult uploadPicture() {return new PictureUploadResult(null);}

}
