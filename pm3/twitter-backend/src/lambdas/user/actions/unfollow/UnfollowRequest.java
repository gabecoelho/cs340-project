package lambdas.user.actions.follow.unfollow;

public class UnfollowRequest {
    public String follower;
    public String following;

    public UnfollowRequest(String follower, String following) {
        this.follower = follower;
        this.following = following;
    }
}
