package lambdas.dao;

import lambdas.follow.FollowRequest;
import lambdas.follow.FollowResult;
import lambdas.followers.FollowersResult;
import lambdas.following.FollowingResult;
import lambdas.follows.FollowsResult;
import lambdas.signup.SignupRequest;
import lambdas.signup.SignupResult;
import lambdas.unfollow.UnfollowRequest;
import lambdas.unfollow.UnfollowResult;
import lambdas.user.UserResult;

public interface IUserDAO {
    SignupResult signUp(SignupRequest request);
    UserResult getUser(String handle);
    FollowResult follow(FollowRequest request);
    UnfollowResult unfollow(UnfollowRequest request);
    FollowersResult getFollowers(String handle, int pageSize, String lastResult);
    FollowingResult getFollowing(String handle, int pageSize, String lastResult);
    FollowsResult follows(String follower, String followee);
    String uploadProfilePicture(String handle, String base64String);
}
