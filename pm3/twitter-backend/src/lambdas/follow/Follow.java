package lambdas.follow;

import lambdas.dao.UserDAO;

public class Follow {
    public UserDAO userDAO = new UserDAO();

    public FollowResult handleRequest(String follower_id, String followee_id) {
        return userDAO.follow(follower_id, followee_id);
    }
}
