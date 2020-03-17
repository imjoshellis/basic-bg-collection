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
  end

  post "/board-games/new" do
    # TODO: When you slug, make sure to remove colons and apostrophes, etc!
  end

  get "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    erb :'board_games/show'
  end

  delete "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    @user.board_games.select { |bg| bg != @game } if @user.board_games.include?(@game)
  end

  post "/board-games/:slug" do
    @game = get_game(params[:slug])
    @user = get_user
    @user.board_games << @game unless @user.board_games.include?(@game)
  end
end
