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
    erb :'board_games/new'
  end

  # check if slug exists already
  # check bgg url
  post "/board-games/new" do
    slug = params[:name].downcase.split(/\s/).collect { |w| w.split(/[^a-zA-Z0-9]+/).join("") }.join("-")
    if params[:bgg_url].size > 0 && params[:bgg_url].downcase.match?(/.*boardgamegeek.com\/boardgame\/[0-9]+/)
      bgg_url = params[:bgg_url]
    else
      session[:message] = "invalid"
      redirect "/board-games/new"
    end

    if get_game(slug)
      session[:message] = "exsists"
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
    @user.board_games = @user.board_games.select { |bg| bg != @game } if @user.board_games.include?(@game)
    redirect "/board-games/#{params[:slug]}"
  end

  patch "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    @user.board_games << @game unless @user.board_games.include?(@game)
    redirect "/board-games/#{params[:slug]}"
  end

  get "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    erb :'board_games/show'
  end
end
