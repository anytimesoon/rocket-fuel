require './config/environment'

class ApplicationController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/' do
    erb :index
  end

  get '/error' do
    erb :error
  end
end
