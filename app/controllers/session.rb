get '/login' do
  session[:admin] = true
  redirect to("/auth/twitter")
end
 
get '/logout' do
  session[:admin] = nil
  session[:username] = nil
  redirect '/'
end