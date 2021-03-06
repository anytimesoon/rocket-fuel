require './config/environment'
require 'rack-flash'

class CartController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/carts/' do
    erb :'carts/empty'
  end

  get '/carts/:id' do
    @cart = Cart.find(params[:id])
    @user = User.find(@cart.user_id)

    if Helpers.is_logged_in?(session) && @user == Helpers.current_user(session)
      erb :'carts/show'
    else
      redirect '/error'
    end
  end

  post '/carts/:id' do
    @cart = Cart.find(params[:id])
    @cart.total = params[:total]
    @user = User.find(@cart.user_id)
    erb :'carts/sold'
  end

  get '/carts/:id/:cartlineid/delete' do
    cart = Cart.find(params[:id])
    cartline = Cartline.find(params[:cartlineid])
    cartline.destroy
    redirect "/carts/#{cart.id}"

  end
end
