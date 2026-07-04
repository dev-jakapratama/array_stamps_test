require 'prime'

# 1. Create an array of numbers from 1 to 100
numbers = (1..100).to_a

# 2. Process and transform the numbers in reverse order
result = numbers.reverse.map do |num|
  if Prime.prime?(num)
    nil # Skip prime numbers
  elsif num % 3 == 0 && num % 5 == 0
    "FooBar"
  elsif num % 3 == 0
    "Foo"
  elsif num % 5 == 0
    "Bar"
  else
    num.to_s
  end
end.compact

# 3. Print the results horizontally, separated by commas
puts result.join(", ")
