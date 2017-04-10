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

  get '/admin/:id/products' do
    @admin = Admin.find(params[:id])
    if @admin == Helpers.current_admin(session)
      erb :'admin/products/index'
    else
      "You're not an admin"
    end
  end

  post '/admin/:id/products' do
    admin = Admin.find(params[:id])

    product = Product.new(name: params[:name], price: params[:price], description: params[:description])
    product.slugifier

    @squarename = product.slug + '-square.jpg'
    squaretempfile = params[:squarepic][:tempfile]
    File.open("./public/img/#{@squarename}", 'wb') do |f|
      f.write(squaretempfile.read)
    end

    @widename = product.slug + '-wide.jpg'
    widetempfile = params[:widepic][:tempfile]
    File.open("./public/img/#{@widename}", 'wb') do |f|
      f.write(widetempfile.read)
    end

    redirect "/products/#{product.slug}"
  end


  get '/admin/:id/products/new' do
    @admin = Admin.find(params[:id])
    if @admin == Helpers.current_admin(session)
      erb :'admin/products/new'
    else
      "You're not an admin"
    end
  end

  patch '/admin/:id/products/:productid' do
    @admin = Admin.find(params[:id])
    @product = Product.find(params[:productid])
    @product.name = params[:name]
    @product.price = params[:price]
    @product.description = params[:description]
    @product.slugifier
    redirect "/products/#{@product.slug}"
  end

  get '/admin/:id/products/:productid/edit' do
    @admin = Admin.find(params[:id])
    @product = Product.find(params[:productid])
    if @admin == Helpers.current_admin(session)
      erb :'admin/products/edit'
    else
      "You're not an admin"
    end
  end

  get '/admin/:id/products/:productid/delete' do
    @admin = Admin.find(params[:id])
    @product = Product.find(params[:productid])
    if @admin == Helpers.current_admin(session)
      @product.destroy
      redirect "/admin/#{@admin.id}/products"
    else
      "You're not an admin"
    end
  end

end
