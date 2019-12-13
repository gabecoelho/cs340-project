package lambdas.unfollow;

import lambdas.dao.UserDAO;

public class UnfollowRetriever {
   public UnfollowResult handleRequest(UnfollowRequest request) {
       return new UserDAO().unfollow(request);
   }
}
