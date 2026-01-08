puts 'Enter the length of the triangle base'
a = gets.chomp.to_i
puts 'Enter the height of the triangle'
h = gets.chomp.to_i

if h <= 0 || a <= 0
  abort 'Enter valid data'
end

result = (0.5.to_f * a * h)
puts result
