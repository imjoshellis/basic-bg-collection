require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
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
      User.create(params)
      redirect "/success"
    else
      redirect "/signup"
    end
  end
end
