# frozen_string_literal: true

puts 'Введите день '
day = gets.chomp.to_i
puts 'Введите месяц '
month = gets.chomp.to_i
puts 'Введите год '
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] = 29 if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0)

sum = 0
(0..month - 2).each do |i|
  sum += days[i]
end
sum += day

puts "День: #{sum}"
