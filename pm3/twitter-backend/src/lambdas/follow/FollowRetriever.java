package lambdas.follow;

import lambdas.dao.UserDAO;

public class FollowRetriever {

    public FollowResult handleRequest(String follower_id, String followee_id) {
        return new UserDAO().follow(follower_id, followee_id);
    }
}
