# frozen_string_literal: true

puts 'Enter day'
day = gets.chomp.to_i
puts 'Enter month'
month = gets.chomp.to_i
puts 'Enter year'
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] = 29 if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0)

puts days.take(month - 1).sum + day
