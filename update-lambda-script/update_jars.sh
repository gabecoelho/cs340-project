#!/bin/bash

# update lambdas

LAMBDAS=(signup get_story get_hashtag get_user get_followers get_following follow unfollow post_status get_feed upload_picture edit_picture follows queue_writer queue_batch)

JAR="fileb://pm3/twitter-backend/out/artifacts/twitter_backend_jar/twitter-backend.jar"

for i in "${LAMBDAS[@]}"
do
  echo $i
  aws lambda update-function-code --function-name $i --zip-file $JAR
done

