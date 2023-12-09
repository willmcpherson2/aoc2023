module Day1_1

def self.main
  File
    .read("input/day1.txt")
    .lines("\n")
    .map { |line| line.scan /\d/ }
    .map { |digits| "#{digits.first}#{digits.last}".to_i }
    .sum
end

end
