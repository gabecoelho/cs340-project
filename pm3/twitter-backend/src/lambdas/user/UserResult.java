package lambdas.user;

import lambdas.dto.UserDTO;

public class UserResult {
    UserDTO user;

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
}
