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
    @admin = Admin.find_by(name: params[:name])
    binding.pry
    if @admin && @admin.authenticate(params[:password])
      binding.pry
      session[:admin_id] = @admin.id
      redirect "/admin/#{@admin.id}"
    else
      binding.pry
      flash[:message] = "Something went wrong. Please try again."
      @params = params
      erb :'/admin/login'
    end
  end

  get '/admin/:id' do
    @admin = Admin.find(params[:id])
    if @admin == Helpers.current_admin(session)
      erb :'admin/show'
    else
      "You're not an admin"
    end
  end

  get 'admin/:id/users' do
    if @admin == Helpers.current_admin(session)
      erb :'admin/users'
    else
      "You're not an admin"
    end
  end
end
