#!/bin/bash

# update lambdas

#LAMBDAS=(sign_in sign_up search_hashtag get_user get_user_feed get_following follow unfollow get_followers get_user_tweets send_tweet is_following  sns_processor sqs_processor get_cover_image put_cover_image)

LAMBDAS=(signup get_story get_hashtag get_user get_followers get_following follow unfollow post_status get_feed upload_picture edit_picture follows)
#JAR="fileb://twitter/Server/out/artifacts/Server_jar/Server.jar"
JAR="fileb://pm3/twitter-backend/out/artifacts/twitter_backend_jar/twitter-backend.jar"

for i in "${LAMBDAS[@]}"
do
  echo $i
  aws lambda update-function-code --function-name $i --zip-file $JAR
done

