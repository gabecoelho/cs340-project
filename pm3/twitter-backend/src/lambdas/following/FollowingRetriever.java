package lambdas.following;

import lambdas.dao.UserDAO;

public class FollowingRetriever {
    public FollowingResult handleRequest(FollowingRequest request) {
        return new UserDAO().getFollowing(request.handle, request.pageSize, request.lastResult);
    }
}
