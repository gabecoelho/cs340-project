package lambdas.user.following;

import lambdas.user.User;

import java.util.List;

public class FollowersResult {
    public List<User> followers;

    public FollowersResult(List<User> followers) {
        this.followers = followers;
    }
}
