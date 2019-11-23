package lambdas.user.actions.follow;

public class Follow {
   public FollowResult handleRequest() {
       return new FollowResult("someUser","otherUser", true);
   }
}
