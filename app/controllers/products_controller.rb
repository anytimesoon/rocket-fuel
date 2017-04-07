require './config/environment'

class ProductsController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/products/:slug'do
    @product = Product.find_by(slug: params[:slug])
    erb :'products/show'
  end
end
