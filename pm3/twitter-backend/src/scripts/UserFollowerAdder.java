package scripts;

import lambdas.dao.UserDAO;
import lambdas.dto.UserDTO;
import lambdas.follow.FollowRequest;
import lambdas.signup.SignupRequest;

import java.util.ArrayList;
import java.util.List;

public class UserFollowerAdder {
    protected static String userFollowerHandle = "follower";
    protected static String userFollowerName = "Follower ";
    protected static String userPhoto = "https://340-twitter-bucket.s3-us-west-2.amazonaws.com/santa.jpg";
    protected static UserDAO userDAO = new UserDAO();

    public static void main(String[] args) {
        /*
        This program should do the following:
            - Create 10k users with different names, different handles, and the same profile pictures
            (Follower 1, follower1, https://340-twitter-bucket.s3-us-west-2.amazonaws.com/santa.jpg)
            - Add those users as "gabetest" followers
         */
        System.out.println(" Creating users...");
        // Create Users
        for (int i = 1; i < 10001; i++) {
            UserDTO userDTO = new UserDTO(
                    userFollowerHandle + i,
                    userFollowerName + i,
                    userPhoto
            );
            SignupRequest signupRequest = new SignupRequest();
            signupRequest.userDTO = userDTO;
            userDAO.signUp(signupRequest);
        }
        System.out.println("Finished creating users.");

        System.out.println("Now adding followers...");
        // Add followers
        for (int i = 1; i < 10001; i ++) {
            FollowRequest followRequest = new FollowRequest();
            followRequest.follower_handle = userFollowerHandle + i;
            followRequest.follower_name = userFollowerName + i;
            followRequest.followee_handle = "gabetest";
            followRequest.followee_name = "Gabe Test";

            userDAO.follow(followRequest);
        }
        System.out.println("Finished adding all users AND followers");
    }
}
