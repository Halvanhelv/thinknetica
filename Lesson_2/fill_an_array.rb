array = [10]
stop = 100

loop do
  n = array.last + 5
  if n <= stop
    array.push n
  else
    break
  end
end

puts array
