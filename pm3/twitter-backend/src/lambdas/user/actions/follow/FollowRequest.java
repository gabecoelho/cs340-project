package lambdas.user.actions.follow;

public class FollowRequest {
    public String follower;
    public String following;

    public FollowRequest(String follower, String following) {
        this.follower = follower;
        this.following = following;
    }
}
