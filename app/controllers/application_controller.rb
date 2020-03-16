require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(64) }
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  get "/login" do
    erb :login
  end

  post "/signup" do
    if params[:username].size > 0 && params[:password].size > 0
      session[:user_id] = User.create(params).id
      redirect "/success"
    else
      redirect "/signup"
    end
  end

  get "/success" do
  end
end
