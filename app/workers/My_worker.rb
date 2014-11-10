# app/models/tweet_worker.rb
class MyWorker
  include Sidekiq::Worker

  def perform(tweet_id)
  	Sidekiq::Stats.new.reset
    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

  	# byebug
    tweet = Tweet.find(tweet_id)
    @user = tweet.twitter_user
    twitter_client = MyWorker.client(@user.access_token, @user.access_token_secret)
    twitter_client.update(tweet.tweet_text)
  end

  private
   def self.client(access_token1, access_token_secret1)
     Twitter::REST::Client.new do |config|
         config.consumer_key        = API_KEYS["development"]["twitter_consumer_key_id"]
         config.consumer_secret     = API_KEYS["development"]["twitter_consumer_secret_key_id"]
         config.access_token        = access_token1
         config.access_token_secret = access_token_secret1
     end
   end
	
end