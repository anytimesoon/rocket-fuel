require './config/environment'
require 'rack-flash'

class UsersController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/users/' do
    "OOPS!"
  end

  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    erb :'/users/show'
  end

  patch '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.address = params[:address]
    @user.slugifier
    erb :'/users/show'
  end

  get '/users/:slug/edit' do
    @user = User.find_by(slug: params[:slug])
    erb :'/users/edit'
  end

  get '/users/:slug/delete' do
    @user = User.find_by(slug: params[:slug])
    @user.destroy
    session.clear
    redirect '/'
  end

end
