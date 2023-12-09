require_relative "day2_1"

module Day2_2

def self.power_of_colour(game, colour)
  game[:sets]
    .map { |set| set.filter { |draw| draw[:colour] == colour }.map { |draw| draw[:num] }.max || 0 }
    .max
end

def self.power(line)
  game = Day2_1.parse_game(line)
  power_of_colour(game, "red") * power_of_colour(game, "green") * power_of_colour(game, "blue")
end

def self.main
  File
    .read("input/day2.txt")
    .lines("\n")
    .map { |line| power(line) }
    .sum
end

end
