puts 'Enter 3 numbers'
puts 'Enter the first number'
a = gets.chomp.to_f
puts 'Enter the second number'
b = gets.chomp.to_f
puts 'Enter the third number'
c = gets.chomp.to_f

D = b**2 - 4 * a * c
if D < 0
  puts 'No roots'
elsif  D == 0
  x = - b / 2 * a
  puts "found one root = #{x}, Discriminant equals #{D}"
else
  c = Math.sqrt(D)
  x1 = (-b + c) / (2 * a)
  x2 = (-b - c) / (2 * a)
  puts "First root = #{x1}, Second root = #{x2}, Discriminant = #{D} "
end
