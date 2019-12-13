package lambdas.signup;

import lambdas.dao.UserDAO;

public class SignupRetriever {
    public SignupResult handleRequest(SignupRequest request) {
        return new UserDAO().signUp(request);
    }
}
