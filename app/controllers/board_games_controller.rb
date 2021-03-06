class BoardGamesController < ApplicationController
  def get_game(slug)
    BoardGame.find_by(slug: slug)
  end

  get "/board-games" do
    @user = get_user
    erb :'/board_games/index'
  end

  get "/boardgames" do
    redirect "/board-games"
  end

  get "/board-games/new" do
    @error = session[:message].dup
    session[:message]&.clear
    erb :'board_games/new'
  end

  # check if slug exists already
  # check bgg url
  post "/board-games/new" do
    if params[:name].match?(/[^a-zA-Z0-9\-\:\&\!\,\.\?\'\"\(\)]/)
      session[:message] = "invalid_name"
      redirect "/board-games/new"
    end

    slug = params[:name].downcase.split(/\s/).collect { |w| w.split(/[^a-zA-Z0-9]+/).join("") }.join("-")

    # see if user tried to add bgg_url. if so, validate
    if params[:bgg_url].size > 0
      if params[:bgg_url].downcase.match?(/.*boardgamegeek.com\/boardgame\/[0-9]+/)
        bgg_url = params[:bgg_url]
      else
        session[:message] = "invalid_url"
        redirect "/board-games/new"
      end
    end

    if get_game(slug)
      session[:message] = "exists"
      redirect "/board-games/new"
    else
      @game = BoardGame.new(name: params[:name], slug: slug)
      @game.bgg_url = params[:bgg_url] if params[:bgg_url].size > 0
      @game.save
      redirect :"board-games/#{slug}"
    end
  end

  get "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    erb :'board_games/show'
  end

  # TODO: make it so if you're the only one with a certain game in your collection, it deletes the game from the db.
  delete "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    @user.board_games.delete(@game)
    redirect "/board-games/#{params[:slug]}"
  end

  patch "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    unless @user.board_games.include?(@game)
      UserGame.create(user_id: @user.id, board_game_id: @game.id)
    end
    redirect "/board-games/#{params[:slug]}"
  end

  get "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    erb :'board_games/show'
  end
end
