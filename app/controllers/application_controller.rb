require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "70c3aaf2c43b9023a5234e931357b3d9ddbdf516fe9308a33effa54878a0a1c13c9c5ddc4a0491c9a87a6071e8b3cf1d91a57e5aff20a32e7416aa65224d3cce"
  end

  def get_user
    User.find(session[:user_id]) unless session[:user_id].nil?
  end

  get "/" do
    if session[:user_id].nil?
    erb :index
    else
      redirect '/board-games'
    end
  end
end
