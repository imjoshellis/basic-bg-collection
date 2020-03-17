class BoardGamesController < ApplicationController
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
    @game = BoardGame.find_by(slug: params[:slug])
    @user = get_user
    erb :'board_games/show'
  end

  delete "/board-games/:slug" do
    @user = get_user
  end
end
