module Day2_1

TEST1 = "Game 49: 1 blue, 2 red; 3 green; 4 blue"
TEST2 = "Game 49: 2 red; 2 red, 9 blue; 4 blue, 1 green"
TEST3 = <<-EOF
Game 49: 1 blue, 2 red; 3 green; 4 blue
Game 50: 2 red; 2 red, 15 blue; 4 blue, 1 green
EOF
TEST4 = <<-EOF
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
EOF

GAME = Regexp.new(/Game (\d+):(.*)/)
SET = Regexp.new(/( .*?)(;|\z)/)
DRAW = Regexp.new(/( (\d+) (red|green|blue))(,|\z)/)

def self.parse_game(s)
  game = GAME.match(s)
  game_id = game[1].to_i
  sets =
    game[2]
      .scan(SET)
      .map { |set| set[0].scan(DRAW) }
      .map { |draws| draws.map { |draw| {num: draw[1].to_i, colour: draw[2]} } }
  {game_id: game_id, sets: sets}
end

LIMITS = {
  "red"=>12,
  "green"=>13,
  "blue"=>14,
}

def self.set_impossible(set)
  set.any? { |draw| draw[:num] > LIMITS[draw[:colour]] }
end

def self.line_to_possible_game_id(line)
  game = parse_game(line)
  impossible = game[:sets].any? { |set| set_impossible(set) }
  if impossible
    nil
  else
    game[:game_id]
  end
end

def self.main
  File
    .read("input/day2.txt")
    .lines("\n")
    .map { |line| line_to_possible_game_id(line) }
    .compact
    .sum
end

end
