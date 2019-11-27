package lambdas.unfollow;

public class UnfollowResult {
    public String follower;
    public String following;
    public boolean follows;

    public UnfollowResult(String follower, String following, boolean follows) {
        this.follower = follower;
        this.following = following;
        this.follows = follows;
    }
}
