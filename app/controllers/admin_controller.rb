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

end