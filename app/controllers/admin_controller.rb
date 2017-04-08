require './config/environment'
require 'rack-flash'

class AdminController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/admin' do
    erb :'admin/login'
  end

  post '/admin' do
    if !Helpers.is_email?(params[:email])
      flash[:message] = "Must be valid email address"
      @params = params
      binding.pry
      erb :'/admin/show'
    end
    binding.pry
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:message] = "Something went wrong. Please try again."
      @params = params
      erb :'/admin/show'
    end
  end

end
