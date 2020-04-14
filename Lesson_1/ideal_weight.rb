puts 'Введите свое имя'
name = gets.chomp.to_s
puts 'Введите свой рост в см'
height = gets.chomp.to_i
if height <= 0
  abort 'Введите нормальный вес'
end

perfect  =  (height - 110) * 1.15
if perfect >= 0
puts "Уважаемый #{name} ваш идеальный вес -- #{perfect} кг"
else
  puts 'Ваш вес уже оптимальный'
end


