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
    admin = Admin.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect "/admin/#{admin.id}"
    else
      flash[:message] = "Something went wrong. Please try again."
      @params = params
      erb :'/admin/login'
    end
  end

end
