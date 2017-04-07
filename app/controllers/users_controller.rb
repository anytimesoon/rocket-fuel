require './config/environment'
require 'rack-flash'

class UsersController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    erb :'/users/show'
  end

end