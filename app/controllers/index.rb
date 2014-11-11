configure do
  enable :sessions
end

get '/' do
  erb :index
end

post '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  job_id = @user.post_tweet!(params[:tweet_msg])
  redirect "/status/#{job_id}"
end

get '/tweet' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  @tweets = @user.fetch_tweets!
  erb :show, layout: false
end

post '/tweet_later' do
  halt(401,'Not Authorized') unless admin?
  @user = TwitterUser.find_by(twitter_username: session[:username])
  job_id = @user.post_tweet_later!(params[:tweet_msg1], params[:time])
  redirect "/status/#{job_id}"
end
 
get '/public' do
  "This is the public page - everybody is welcome!"
end
 
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "This is the private page - members only"
end

get '/status/:job_id' do
  @job_id = params[:job_id]
  job_is_complete(params[:job_id]).to_s
end