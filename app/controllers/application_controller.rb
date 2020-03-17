require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "70c3aaf2c43b9023a5234e931357b3d9ddbdf516fe9308a33effa54878a0a1c13c9c5ddc4a0491c9a87a6071e8b3cf1d91a57e5aff20a32e7416aa65224d3cce"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if !!session[:user_id]
      redirect "/" # redirect to index if already logged in
    else
      @error = session[:message]
      session[:message].clear
      erb :signup
    end
  end

  get "/login" do
    if !!session[:user_id]
      redirect "/" # redirect to index if already logged in
    else
      erb :login
    end
  end

  def valid_username?(username)
    unless User.find_by(username: username).nil?
      session[:message] = "exists"
      return false
    end
    return true if username.match(/[a-zA-Z0-9\-\_]{3,12}/)

    session[:message] = "invalid"
    return false
  end

  def valid_password?(password)
    return true if password.match(/[a-zA-Z0-9\-\_]{3,12}/)
    
    session[:message] = "invalid"
    return false
  end

  post "/signup" do
    if valid_username?(params[:username]) && valid_password?(params[:password])
      user = User.new(params)
      user.slug = user.username.downcase.split(" ").join("-") 
      user.save
      session[:user_id] = user.id
      
      redirect "/whoami"
    else
      
      redirect "/signup"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/whoami"
    else
      @error = true
      redirect "/login"
    end
  end

  get "/whoami" do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    erb :whoami
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
