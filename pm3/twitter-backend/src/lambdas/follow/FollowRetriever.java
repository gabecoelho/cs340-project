package lambdas.follow;

import lambdas.dao.UserDAO;

public class FollowRetriever {
    public FollowResult handleRequest(FollowRequest request) {
        return new UserDAO().follow(request);
    }
}
