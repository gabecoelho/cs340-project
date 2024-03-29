package lambdas.dto;

public class TweetDTO {

    public String userHandle;
    public String userName;
    public String userPhoto;
    public String message;
    public String attachment;
    public String timestamp;

    public TweetDTO(String userHandle, String userName, String userPhoto, String message, String attachment, String timestamp) {
        this.userHandle = userHandle;
        this.userName = userName;
        this.userPhoto = userPhoto;
        this.message = message;
        this.attachment = attachment;
        this.timestamp = timestamp;
    }

    public TweetDTO(){}

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

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
