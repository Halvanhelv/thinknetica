puts 'Enter the length of 3 sides of the triangle'

puts 'First side'

a = gets.chomp.to_i
puts 'Second side'
b = gets.chomp.to_i
puts 'Third side'
c = gets.chomp.to_i

if a == b && b == c
  equilateral = true
else
  equilateral = false

  isosceles = a == b || b == c || a == c ? true : false
end
side = [a, b, c]
hypotenuse = side.max

side.delete_at(side.index(hypotenuse))
right_triangle = (hypotenuse**2) == ( (side[0]**2) + (side[1]**2) ) ? true : false
if equilateral
  puts 'Triangle is equilateral'
elsif isosceles && right_triangle
  puts 'Triangle is isosceles and right'
elsif !isosceles && right_triangle
  puts 'Triangle is right'
elsif isosceles && !right_triangle
  puts 'Isosceles triangle'
else
  puts 'Just a triangle'
end
