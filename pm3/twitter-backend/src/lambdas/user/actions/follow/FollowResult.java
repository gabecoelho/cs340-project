package lambdas.user.actions.follow;

public class FollowResult {
    public String follower;
    public String following;
    public boolean follows;

    public FollowResult(String follower, String following, boolean follows) {
        this.follower = follower;
        this.following = following;
        this.follows = follows;
    }
}
