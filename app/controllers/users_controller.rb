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

  post "/signup" do
    slug = params[:username].downcase
    @user = User.create(username: params[:username], password: params[:password], slug: slug)

    if @user.errors.size == 0
      session[:user_id] = @user.id
      redirect "/board-games"
    else
      erb :signup
    end
  end

  post "/login" do
    @user = User.find_by(slug: slug)
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      session[:message] = "invalid"
      redirect "/login"
    end
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

  post "/users/:slug" do
    @user = User.find_by(slug: params[:slug])
    if params[:bio].size > 0 && @user = User.find(session[:user_id])
      @user.bio = params[:bio]
      @user.save
      redirect "/users/#{@user.slug}"
    end
  end

  patch "/users/:slug" do
    @user = User.find_by(slug: params[:slug])
    if params[:bio].size > 0 && @user = User.find(session[:user_id])
      User.update(@user.id, bio: params[:bio])
      redirect "/users/#{@user.slug}"
    end
  end

  delete "/users/:slug" do
    @user = User.find_by(slug: params[:slug])
    if @user = User.find(session[:user_id])
      User.update(@user.id, bio: nil)
      redirect "/users/#{@user.slug}"
    end
  end
end
