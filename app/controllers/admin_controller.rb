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
    if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect "/admin/#{@admin.id}"
    else
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

  get '/admin/:id/users' do
    @admin = Admin.find(params[:id])
    if @admin == Helpers.current_admin(session)
      erb :'admin/users'
    else
      "You're not an admin"
    end
  end

  get '/admin/:id/product' do
    @admin = Admin.find(params[:id])
    if @admin == Helpers.current_admin(session)
      erb :'admin/product'
    else
      "You're not an admin"
    end
  end

  post '/admin/:id/product' do
    admin = Admin.find(params[:id])
    binding.pry
    product = Product.new(name: params[:name], price: params[:price], description: params[:description])
    product.slugifier
    redirect "/products/#{product.id}"
  end
end
