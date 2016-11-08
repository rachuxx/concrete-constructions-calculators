require_relative 'constants.rb'
require 'pry'
puts 'What kind of excercise You have to solve?'
puts 'Type:'
puts '1 - I need to calculate given section resistance.'
state = gets.chomp.to_i

case state
when 1 then
  con_ix = con_class_index
  c_nom = con_cover
  # steel = Struct.new(:fyk, :e_s, :fyd)
  # puts 'Steel: fyk ?'
  # fyk = gets.chomp.to_f
  # puts 'Steel: Es ?'
  # es = gets.chomp.to_f
  # steel(fyk, es)
  # steel.fyk
  con_par(1, con_ix)
end
