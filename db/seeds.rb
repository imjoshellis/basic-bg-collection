user_list = {
  "josh" => {
    username: "josh",
    slug: "josh",
    password: "josh"
  },
  "anna" => {
    username: "anna",
    slug: "anna",
    password: "anna"
  },
  "joe" => {
    username: "joe",
    slug: "joe",
    password: "joe"
  },
  "don" => {
    username: "don",
    slug: "don",
    password: "don"
  }
}

user_list.each do |name, hash|
  u = User.create(hash)
end

board_game_list = {
  "Kemet" => {
    name: "Kemet",
    slug: "kemet",
    bgg_url: "https://boardgamegeek.com/boardgame/127023/kemet"
  },
  "Inis" => {
    name: "Inis",
    slug: "inis",
    bgg_url: "https://boardgamegeek.com/boardgame/155821/inis"
  },
  "Great Western Trail" => {
    name: "Great Western Trail",
    slug: "great-western-trail",
    bgg_url: "https://boardgamegeek.com/boardgame/193738/great-western-trail"
  },
  "Isle of Skye" => {
    name: "Isle of Skye",
    slug: "isle-of-skye",
    bgg_url: "https://boardgamegeek.com/boardgame/176494/isle-skye-chieftain-king"
  },
  "Takenoko" => {
    name: "Takenoko",
    slug: "takenoko",
    bgg_url: "https://boardgamegeek.com/boardgame/70919/takenoko"
  },
  "Century: Spice Road" => {
    name: "Century: Spice Road",
    slug: "century-spice-road",
    bgg_url: "https://boardgamegeek.com/boardgame/209685/century-spice-road"
  }

}

board_game_list.each do |name, hash|
  bg = BoardGame.create(hash)
end

josh = User.find_by(username: "josh")
josh.board_games << BoardGame.find_by(slug: "kemet")
josh.board_games << BoardGame.find_by(slug: "inis")
josh.board_games << BoardGame.find_by(slug: "takenoko")

anna = User.find_by(username: "anna")
anna.board_games << BoardGame.find_by(slug: "kemet")
anna.board_games << BoardGame.find_by(slug: "inis")
anna.board_games << BoardGame.find_by(slug: "takenoko")

joe = User.find_by(username: "joe")
joe.board_games << BoardGame.find_by(slug: "isle-of-skye")
joe.board_games << BoardGame.find_by(slug: "great-western-trail")
joe.board_games << BoardGame.find_by(slug: "takenoko")

don = User.find_by(username: "don")
don.board_games << BoardGame.find_by(slug: "century-spice-road")
