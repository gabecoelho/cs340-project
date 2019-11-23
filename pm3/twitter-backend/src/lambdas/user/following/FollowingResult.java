package lambdas.user.following;

import lambdas.user.User;

import java.util.List;

public class FollowingResult {
    public List<User> following;

    public FollowingResult(List<User> following) {
        this.following = following;
    }
}
