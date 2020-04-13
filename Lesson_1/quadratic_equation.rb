puts 'Введите 3 числа'
puts 'Введите первое число'
a = gets.chomp.to_f
puts 'Введите второе число'
b = gets.chomp.to_f
puts 'Введите третье число'
c = gets.chomp.to_f

D = b**2 - 4 * a * c
if D < 0
  puts 'Нет корней'
elsif  D == 0
  x = - b / 2 * a
  puts "найден один корень = #{x}, Дискриминант равен  #{D}"
else
  c = Math.sqrt(D)
  x1 = (-b + c) / (2 * a)
  x2 = (-b - c) / (2 * a)
  puts "Первый корень  = #{x1}, Второй корень = #{x2}, Дискриминант =  #{D} "
end