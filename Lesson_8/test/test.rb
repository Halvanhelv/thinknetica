# frozen_string_literal: true

# block = proc { |x| puts x }
# block = proc { |x| puts x }
# block = lambda { |x| puts x }
# block = ->(x) {  puts x }
# PROC принимает любое количество аргументов(если их больше чем нужно) а лямбда нет
# block = proc { puts 'x' }
# def m(block)
#   x = 'good'
#   puts "X from method #{block}"
#   yield block
#
# end
# m('str') { |x| puts x }




# frozen_string_literal: true

# block1 = proc { |str| puts str + 'dwd' }
# def m1(str, block)
#   x = 'good'
#   puts "X from method #{block}"
#   block.call(str)
#
# end
#
# m1('Abc', block1)



# def m1(str, &block)
#   x = 'good'
#   puts "X from method #{block}"
#   block.call(str)
#
# end
#
# m1('Abc') { |str| puts str + 'dwd' }


# def m1(str, &block)
#   x = 'good'
#   puts "X from method #{block}"
#   block.call(str)
#   yield str
#
# end
#
# m1('Abc') { |str| puts str + 'dwd' }
#
#
#
#
# def m1(str, &block)
#   x = 'good'
#   if  block_given? # Если блок передан
#     yield str # или block.call(str)
#   else
#     puts 'Блок не передан'
#     end
#   end
#
#
# m1('Abc') { |str| puts str + 'dwd' }


# В Ruby есть еще один способ записи блоков через lambda, это оператор ->:
#
#     Запись
# ->(x) { puts x }
# это то же самое, что и
# lambda { |x| puts x }
# только короче.
#     Если встретите такую запись, не пугайтесь, это всего лишь lambda.


# def m1(&block)
#   if block_given? # Если блок передан
#     block.call(1, 2, 3,4) # или block.call(str)
#   else
#     puts 'Блок не передан'
#   end
# end
#
#
# m1() { |f, y, b, a| puts f * y * b;  puts a}




