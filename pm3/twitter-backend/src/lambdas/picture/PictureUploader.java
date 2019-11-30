package lambdas.picture;

import lambdas.dao.UserDAO;

public class PictureUploader {
    public String handleRequest(PictureUploadRequest request) {
        return new UserDAO().uploadProfilePicture(request.base64EncodedString);
    }
}
