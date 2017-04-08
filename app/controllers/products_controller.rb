require './config/environment'
require 'rack-flash'

class ProductsController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/products/:slug' do
    @product = Product.find_by(slug: params[:slug])
    erb :'products/show'
  end

  post '/products/:slug' do
    product = Product.find_by(slug: params[:slug])

    if !Helpers.is_logged_in?(session)
      redirect '/login'
    elsif !session[:cart_id]
      user = Helpers.current_user(session)
      cart = Cart.create(product_id: product.id, user_id: user.id)
      session[:cart_id] = cart.id
    end

    cart = Cart.find(session[:cart_id])
    cartline = Cartline.new(cart_id: cart.id, product_id: product.id, product_amount: params[:product_amount])

    cart.cartlines << cartline
    if cart.save
      redirect "/carts/#{cart.id}"
    else
      flash[:message] = "Something didn't quite work. Please try again"
      redirect "/products/#{product.slug}"
    end

  end
end
