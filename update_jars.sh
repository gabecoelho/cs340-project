#!/bin/bash

# update lambdas

#LAMBDAS=(sign_in sign_up search_hashtag get_user get_user_feed get_following follow unfollow get_followers get_user_tweets send_tweet is_following get_following_number get_followers_number sns_processor sqs_processor get_cover_image put_cover_image search_users)

LAMBDAS=(get_story get_hashtag get_user get_followers get_following follow unfollow post_status get_feed edit_picture follows)
#JAR="fileb://twitter/Server/out/artifacts/Server_jar/Server.jar"
JAR="fileb://pm3/twitter-backend/out/artifacts/twitter_backend_jar/twitter-backend.jar"

for i in "${LAMBDAS[@]}"
do
  echo $i
  aws lambda update-function-code --function-name $i --zip-file $JAR
done

