package lambdas.unfollow;

public class Unfollow {
   public UnfollowResult handleRequest() {
       return new UnfollowResult("someUser","otherUser", false);
   }
}
