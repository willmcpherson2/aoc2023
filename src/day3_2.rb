require_relative "day3_1"

module Day3_2

TEST1 = <<-EOF
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
EOF

def self.main
  schematic = Day3_1.get_schematic(File.read("input/day3.txt"))
  schematic
    .map { |char| mark_as_gear(schematic, char) }
    .chunk { |char| char[:type] == :char }
    .map { |is_char, chars| is_char ? make_gear(chars) : nil }
    .compact
    .group_by { |char| char[:gears] }
    .select { |gears, chars| chars.length == 2 }
    .map { |gears, chars| chars.map { |char| char[:num] } }
    .map { |a, b| a * b }
    .sum
end

def self.make_gear(chars)
  if chars.any? { |char| char[:gear] }
    num =
      chars
        .reduce("") { |string, char| string + char[:char] }
        .to_i
    gears =
      chars
        .map { |char| char[:gear] }
        .compact
        .uniq
    {type: :char, num: num, gears: gears }
  else
    nil
  end
end

def self.mark_as_gear(schematic, char)
  (x, y), ch = char
  if ch[:type] == :char
    gear = neighbour_is_gear(schematic, x, y, ch)
    if gear
      ch.merge(:gear => gear)
    else
      ch
    end
  else
    ch
  end
end

def self.neighbour_is_gear(schematic, x, y, char)
  neighbours = [
    [x - 1, y - 1],
    [x,     y - 1],
    [x + 1, y - 1],
    [x - 1, y    ],
    [x + 1, y    ],
    [x - 1, y + 1],
    [x,     y + 1],
    [x + 1, y + 1],
  ]
  neighbours.find { |neighbour| schematic[neighbour] && schematic[neighbour][:gear] }
end

end
