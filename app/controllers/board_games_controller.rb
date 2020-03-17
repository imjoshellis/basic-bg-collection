class BoardGamesController < ApplicationController

  get "/board-games" do
    erb :'/board_games/index'
  end

  get "/boardgames" do
    redirect "/board-games"
  end
end
