package lambdas.user.actions;

public class FollowRequest {
    public String follower;
    public String following;

    public FollowRequest(String follower, String following) {
        this.follower = follower;
        this.following = following;
    }
}
