require './config/environment'
require 'rack-flash'

class CartController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/carts/:id' do
    @cart = Cart.find(params[:id])
    @user = User.find(@cart.user_id)
    erb :'carts/show'
  end
end