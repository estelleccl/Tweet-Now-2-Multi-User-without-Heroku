configure do
  enable :sessions
end

get '/' do
  erb :index
end

post '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  @user.post_tweet!(params[:tweet_msg])
  # @tweets = @user.fetch_tweets!
  redirect '/tweet'
end

get '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  @tweets = @user.fetch_tweets!
  erb :show
end
 
get '/public' do
  "This is the public page - everybody is welcome!"
end
 
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "This is the private page - members only"
end