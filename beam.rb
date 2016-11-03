require_relative 'constants.rb'
require 'pry'
puts 'What kind of excercise You have to solve?'
puts 'Type:'
puts '1 - I need to calculate given section resistance.'
state = gets.chomp.to_i

case state
when 1 then
  con_ix = con_class_index
  con_par(1, con_ix)
end
