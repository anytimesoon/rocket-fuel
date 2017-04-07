require './config/environment'
require 'rack-flash'

class SignupController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/signup' do
    erb :'signup/index'
  end

  post '/signup' do
    if !Helpers.is_email?(params[:email])
      flash[:message] = "Must be valid email address"
      @params = params
      redirect :'signup/'
    end

    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      user.slugify
      redirect '/'
    else
      flash[:message] = "Something went wrong. Please try again."
      @params = params
      erb :'signup/'
    end
  end

end
