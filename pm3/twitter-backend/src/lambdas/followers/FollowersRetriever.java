package lambdas.followers;

import lambdas.dao.UserDAO;

public class FollowersRetriever {
    public FollowersResult handleRequest(FollowersRequest request) {
        return new UserDAO().getFollowers(request.handle, request.pageSize, request.lastResult);
    }
}
