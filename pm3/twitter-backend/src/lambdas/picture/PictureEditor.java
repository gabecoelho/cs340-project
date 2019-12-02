package lambdas.picture;

import lambdas.dao.UserDAO;

public class PictureEditor {
    public String handleRequest(PictureEditorRequest request) {
        return new UserDAO().editProfilePicture(request.handle, request.base64EncodedString);
    }
}
