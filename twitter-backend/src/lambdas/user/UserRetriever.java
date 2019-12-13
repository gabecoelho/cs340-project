package lambdas.user;

import lambdas.dao.UserDAO;

public class UserRetriever {
    public UserResult handleRequest(UserRequest request) {
        return new UserDAO().getUser(request.handle);
    }
}
