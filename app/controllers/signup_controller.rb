require './config/environment'

class ApplicationController < Sinatra::Base
  set :public_folder, './public'
  set :views, 'app/views'
  enable :sessions unless test?
  set :session_secret, "secret"

  get '/signup' do
    erb :'signup/index'
  end

end