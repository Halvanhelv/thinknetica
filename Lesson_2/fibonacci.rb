# frozen_string_literal: true

fib = [0]
fib_number = 1
while fib_number < 100
  fib << fib_number
  fib_number = fib[-1] + fib[-2]
end
puts fib
