package lambdas.user;

import lambdas.dao.UserDAO;

public class UserRetriever {
    public UserResult handleRequest(UserRequest request) {
        System.out.println("got to user retriever and we are looking for: " + request.handle);
        return new UserDAO().getUser(request.handle);
    }
}
