module Day3_1

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

TEST2 = <<-EOF
...*
$..1
2...
EOF

def self.main
  schematic =
    File
      .read("input/day3.txt")
      .lines
      .map { |line| line.chars.map { |char| char_type(char) } }
      .each_with_index
      .reduce({}) { |schematic, (line, y)| schematic.merge(line.each_with_index.reduce({}) { |schematic, (char, x)| schematic.merge([x, y] => char) }) }
  schematic
    .map { |char| mark_as_part(schematic, char) }
    .chunk { |char| char[:type] == :char }
    .map { |is_char, chars| is_char ? make_part(chars) : nil }
    .compact
    .sum
end

def self.make_part(chars)
  if chars.any? { |char| char[:part] }
    chars
      .reduce("") { |string, char| string + char[:char] }
      .to_i
  else
    nil
  end
end

def self.mark_as_part(schematic, char)
  (x, y), ch = char
  if ch[:type] == :char && neighbour_is_symbol(schematic, x, y, ch)
    ch.merge(:part => true)
  else
    ch
  end
end

def self.neighbour_is_symbol(schematic, x, y, char)
  neighbours = [
    schematic[[x - 1, y - 1]],
    schematic[[x,     y - 1]],
    schematic[[x + 1, y - 1]],
    schematic[[x - 1, y    ]],
    schematic[[x + 1, y    ]],
    schematic[[x - 1, y + 1]],
    schematic[[x,     y + 1]],
    schematic[[x + 1, y + 1]],
  ]
  neighbours.any? { |neighbour| neighbour && neighbour[:type] == :symbol }
end

DIGIT = Regexp.new(/\d/)
EMPTY = Regexp.new(/\./)
NEWLINE = Regexp.new(/\n/)

def self.char_type(char)
  if char =~ DIGIT
    {type: :char, char: char}
  elsif char =~ EMPTY
    {type: :empty}
  elsif char =~ NEWLINE
    {type: :newline}
  else
    {type: :symbol}
  end
end

end
