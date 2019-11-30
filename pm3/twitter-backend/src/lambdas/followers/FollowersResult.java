package lambdas.followers;

import lambdas.dto.TweetDTO;
import lambdas.dto.UserDTO;

import java.util.List;

public class FollowersResult {
    private List<UserDTO> followers;
    private String lastKey;

    public List<UserDTO> getFollowers() {
        return followers;
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
        followers.add(v);
    }
}
