# frozen_string_literal: true
# Если добавить товар с таким же названием то данные по товару обновятся, нужно оставить так или сделать что бы количество товара и цена добавлялась?
cart = {}
total_price = 0
loop do
  puts 'Введите название товара'
  name = gets.chomp
  break if name.downcase == 'стоп'

  puts 'Введите цену товара'
  price = gets.chomp.to_f
  puts 'Введите количество товара'
  count = gets.chomp.to_f
  cart[name] = { price: price, count: count, total: count * price }
  puts "Конкретный товар #{name} куплен на сумму #{cart[name][:total]}"
end

cart.each { |name, value| total_price += value[:price] * value[:count] }
puts cart
puts "Итого: #{total_price}"