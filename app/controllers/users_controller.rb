class UsersController < ApplicationController
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
    true
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
      slug = params[:username].downcase
      if valid_new_username?(slug) && valid_password?(params[:password])
        user = User.new(params)
        user.slug = slug
        user.save
        session[:user_id] = user.id

        redirect "/board-games"
      end
    end
    redirect "/signup"
  end

  post "/login" do
    if valid_username?(params[:username])
      slug = params[:username].downcase
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

  get "/users" do
    erb :'/users/index'
  end

  get "/users/:slug" do
    @user = User.find_by(slug: params[:slug])
    erb :'/users/show'
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
