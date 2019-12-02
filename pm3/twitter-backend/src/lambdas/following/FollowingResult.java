package lambdas.following;

import lambdas.dao.UserDAO;
import lambdas.dto.UserDTO;

import java.util.ArrayList;
import java.util.List;

public class FollowingResult {
    public List<UserDTO> following = new ArrayList<>();
    private String lastKey;

    public List<UserDTO> getFollowing() {
        return following;
    }

    public String getLastKey() {
        return lastKey;
    }
    public void setLastKey(String value) {
        lastKey = value;
    }
    public boolean hasLastKey() {
        return (lastKey != null && lastKey.length() > 0);
    }
    public void addValue(UserDTO v) {
        following.add(v);
    }
}
