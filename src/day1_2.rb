module Day1_2

PATTERN = Regexp.new /(?=(1|one))|(?=(2|two))|(?=(3|three))|(?=(4|four))|(?=(5|five))|(?=(6|six))|(?=(7|seven))|(?=(8|eight))|(?=(9|nine))/

def self.parse_digits(line)
  line
    .scan(PATTERN)
    .map { |matches| matches.find_index { |match| match.nil?.! } + 1 }
end

def self.main
  File
    .read("input/day1.txt")
    .lines("\n")
    .map { |line| parse_digits(line) }
    .map { |digits| "#{digits.first}#{digits.last}".to_i }
    .sum
end

end
