require './config/environment'
require 'rack-flash'

class LoginController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/login' do
    erb :'/login/index'
  end

  post '/login' do
    if !Helpers.is_email?(params[:email])
      flash[:message] = "Must be valid email address"
      @params = params
      erb :'/login/index'
    end
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:message] = "Something went wrong. Please try again."
      @params = params
      erb :'/login/index'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
