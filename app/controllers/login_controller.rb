require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"
  use Rack::Flash

  get '/login' do
    erb '/'
  end
end