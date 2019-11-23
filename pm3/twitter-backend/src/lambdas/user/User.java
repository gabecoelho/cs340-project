package lambdas.user;

public class User {
    public String userHandle;
    public String userName;
    public String userPicture;

    public User(String userHandle, String userName, String userPicture) {
        this.userHandle = userHandle;
        this.userName = userName;
        this.userPicture = userPicture;
    }

    public String getUserHandle() {
        return userHandle;
    }

    public void setUserHandle(String userHandle) {
        this.userHandle = userHandle;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPicture() {
        return userPicture;
    }

    public void setUserPicture(String userPicture) {
        this.userPicture = userPicture;
    }
}
