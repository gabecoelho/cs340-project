package lambdas.unfollow;

public class UnfollowRequest {
    public String follower;
    public String followee;

    public UnfollowRequest(String follower, String followee) {
        this.follower = follower;
        this.followee = followee;
    }
}
