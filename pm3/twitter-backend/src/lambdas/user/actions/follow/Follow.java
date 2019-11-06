package lambdas.user.actions;

public class Follow {
   public FollowResult handleRequest() {
       return new FollowResult("someUser","otherUser", true);
   }
}
