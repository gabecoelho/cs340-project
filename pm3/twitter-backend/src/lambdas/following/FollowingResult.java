package lambdas.following;

import lambdas.dao.UserDAO;

import java.util.List;

public class FollowingResult {
    public List<UserDAO> following;

    public FollowingResult(List<UserDAO> following) {
        this.following = following;
    }
}
