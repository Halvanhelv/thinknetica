puts 'Введите длинну основания треугольника'
a = gets.chomp.to_i
puts 'Введите высоту треугольника'
h = gets.chomp.to_i

if h <= 0 || a <= 0
  abort 'Введите валидные данные'
end

result = (0.5.to_f * a * h)
puts result