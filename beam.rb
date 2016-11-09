require_relative 'constants.rb'
require_relative 'methods.rb'
require 'pry'

puts 'What kind of excercise You have to solve?'
puts 'Type:'
puts '1 - I need to calculate given section resistance.'
state = gets.chomp.to_i

case state
when 1 then
  steel_cl # Define steel
  con_cover # Calculate cover
  con_cl # Define and index concrete class
  xsi_eff_lim # Calculating xsi eff lim
  section # Define section
  reinforcement # Define main reinforcement
  @x_eff = (@as1 * (@stl.fyd / 10)) / (@sec.b * (con_par(0) / 10))
  @xsi_eff = @x_eff / @d
  @ni_eff = @xsi_eff * (1 - 0.5 * @xsi_eff)
  @mrd = ((@ni_eff * (@d**2) * @sec.b * (con_par(0) / 10)) / 100)
  puts "\nSection resistance MRd = #{@mrd} kNm"
  # con_par(1)
end
