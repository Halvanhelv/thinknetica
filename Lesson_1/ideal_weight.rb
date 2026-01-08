puts 'Enter your name'
name = gets.chomp.to_s
puts 'Enter your height in cm'
height = gets.chomp.to_i
if height <= 0
  abort 'Enter a valid weight'
end

perfect  =  (height - 110) * 1.15
if perfect >= 0
puts "Dear #{name} your ideal weight is #{perfect} kg"
else
  puts 'Your weight is already optimal'
end


