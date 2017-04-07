require './config/environment'

class ProductsController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/products/:id'do
    @product = Product.find(params[:id])
    erb :'products/show'
  end
end