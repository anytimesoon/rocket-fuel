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

  post '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    binding.pry
    @user.update(params)
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
