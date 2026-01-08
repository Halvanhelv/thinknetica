# frozen_string_literal: true
# If you add a product with the same name, the product data will be updated. Should it stay this way or should the quantity and price be added?
cart = {}
total_price = 0
loop do
  puts 'Enter product name'
  name = gets.chomp
  break if name.downcase == 'stop'

  puts 'Enter product price'
  price = gets.chomp.to_f
  puts 'Enter product quantity'
  count = gets.chomp.to_f
  cart[name] = { price: price, count: count, total: count * price }
  puts "Specific product #{name} purchased for #{cart[name][:total]}"
end

cart.each { |name, value| total_price += value[:price] * value[:count] }
puts cart
puts "Total: #{total_price}"
