# frozen_string_literal: true

alphabet = ('a'..'z').to_a
new_array = {}
alphabet.each_with_index do |value, key|
  new_array[key] = value if %w[a e i o u].include?(value)
end
puts new_array