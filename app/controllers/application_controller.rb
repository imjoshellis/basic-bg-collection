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
    erb :index
  end

  def auth_routing
    if !!session[:user_id]
      redirect "/" # redirect to index if already logged in
    else
      @error = session[:message].dup
      session[:message]&.clear
    end
  end

  get "/signup" do
    auth_routing
    erb :signup
  end

  get "/login" do
    auth_routing
    erb :login
  end

  def valid_new_username?(slug)
    unless User.find_by(slug: slug).nil?
      session[:message] = "exists"
      false
    end
  end

  def valid_username?(username)
    return true if /[a-zA-Z0-9\-\_]{3,12}/.match?(username)

    session[:message] = "invalid"
    false
  end

  def valid_password?(password)
    return true if /[a-zA-Z0-9\-\_]{3,12}/.match?(password)

    session[:message] = "invalid"
    false
  end

  post "/signup" do
    if valid_username?(params[:username])
      slug = params[:username].downcase.split(" ").join("-")
      if valid_new_username?(slug) && valid_password?(params[:password])
        user = User.new(params)
        user.slug = slug
        user.save
        session[:user_id] = user.id

        redirect "/whoami"
      end
    end
    redirect "/signup"
  end

  post "/login" do
    if valid_username?(params[:username])
      slug = params[:username].downcase.split(" ").join("-")
      user = User.find_by(slug: params[:slug])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/whoami"
      else
        session[:message] = "invalid"
      end
    end

    redirect "/login"
  end

  get "/whoami" do
    @user = get_user
    erb :whoami
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
