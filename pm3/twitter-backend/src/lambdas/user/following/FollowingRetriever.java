package lambdas.user.following;

import lambdas.user.User;

import java.util.ArrayList;
import java.util.List;

public class FollowingRetriever {
    public FollowingResult handleRequest() {

        User follower1 = new User("Follower 1", "follower1", "https://preview.redd.it/oazv1g694ja31.jpg?auto=webp&s=b162960870a6e511d1e42dafa3ed6a4dfb3d16b4");
        User follower2 = new User("Follower 2", "follower2", "https://i.pinimg.com/736x/9b/0e/4d/9b0e4daa1870231d3a69b8d5a1bbd81a.jpg");
        User follower3 = new User("Follower 3", "follower3", "https://pbs.twimg.com/media/Dqewl3NWoAAmhap.jpg");

        List<User> followers = new ArrayList<>();
        followers.add(follower1);
        followers.add(follower2);
        followers.add(follower3);

        return new FollowingResult(followers);
    }
}
