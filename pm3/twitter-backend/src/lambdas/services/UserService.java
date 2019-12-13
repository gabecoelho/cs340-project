package lambdas.services;

import lambdas.dao.UserDAO;
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


public class UserService {

    public UserDAO userDAO = new UserDAO();

    public SignupResult signUp(SignupRequest request) {
        return userDAO.signUp(request);
    }

    public UserResult getUser(String handle) {
        return userDAO.getUser(handle);
    }

    public FollowResult follow(FollowRequest request) {
        return userDAO.follow(request);
    }

    public UnfollowResult unfollow(UnfollowRequest request) {
        return userDAO.unfollow(request);
    }

    public FollowersResult getFollowers(String handle, int pageSize, String lastResult) {
        return userDAO.getFollowers(handle, pageSize, lastResult);
    }

    public FollowingResult getFollowing(String handle, int pageSize, String lastResult) {
        return userDAO.getFollowing(handle, pageSize, lastResult);
    }

    public FollowsResult follows(String follower, String followee) {
        return userDAO.follows(follower, followee);
    }

    public String uploadProfilePicture(String handle, String base64String) {
        return userDAO.uploadProfilePicture(handle, base64String);
    }
}
