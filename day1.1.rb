def sum_of_first_and_last_digits
  File
    .read("day1.txt")
    .lines("\n")
    .map { |line| line.scan /\d/ }
    .map { |digits| "#{digits.first}#{digits.last}".to_i }
    .sum
end

puts sum_of_first_and_last_digits
