class TwitterUser < ActiveRecord::Base

   def fetch_tweets!
      client.user_timeline(self.twitter_username, count: 10)
   end

   def post_tweet!(tweet_msg)
      client.update(tweet_msg)
   end

   def self.find_or_created_by_username(user_info)
      # byebug
      if TwitterUser.exists?(twitter_username: user_info.info.nickname)
         user = TwitterUser.find_by(twitter_username: user_info.info.nickname)
         user.update(access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
         return user
      else
         TwitterUser.create(twitter_username: user_info.info.nickname, access_token: user_info.extra.access_token.token, access_token_secret: user_info.extra.access_token.secret)
      end
   end

   private
   def client
     Twitter::REST::Client.new do |config|
         config.consumer_key        = API_KEYS["development"]["twitter_consumer_key_id"]
         config.consumer_secret     = API_KEYS["development"]["twitter_consumer_secret_key_id"]
         config.access_token        = self.access_token
         config.access_token_secret = self.access_token_secret
     end
   end
end


