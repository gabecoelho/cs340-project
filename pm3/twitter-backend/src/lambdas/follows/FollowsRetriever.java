package lambdas.follows;

import lambdas.dao.UserDAO;

public class FollowsRetriever {
    public FollowsResult handleRequest(FollowsRequest request) {
        return new UserDAO().follows(request.follower_handle, request.followee_handle);
    }
}
