require './config/environment'

class ProductsController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/products/:slug' do
    @product = Product.find_by(slug: params[:slug])
    erb :'products/show'
  end

  patch '/products/:slug' do
    if !Helpers.is_logged_in?(session)
      redirect '/login'
    elsif !session[:cart_id]
      user = current_user
      product = Product.find_by(slug: params[:slug])
      cart = Cart.create(product_id: product.id, user_id: user.id)
      session[:cart_id] = cart.id
    end

    cart = Cart.find_by(session[:cart_id])
    cart.update(params[:product_amount])
  end
end
