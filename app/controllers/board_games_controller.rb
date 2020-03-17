class BoardGamesController < ApplicationController

  get "/board-games" do
    @user = User.find(session[:user_id]) unless session[:user_id].nil?
    erb :'/board_games/index'
  end

  get "/boardgames" do
    redirect "/board-games"

  end
end
