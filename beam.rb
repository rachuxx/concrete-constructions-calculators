require_relative 'constants.rb'
require_relative 'methods.rb'
require 'pry'

puts "\nWhat kind of excercise You have to solve?"
puts 'Type:'
puts '1 - I need to calculate given section resistance.'
state = gets.chomp.to_i

case state
when 1
  steel_cl # Define steel
  con_cover # Calculate cover
  con_cl # Define and index concrete class
  xsi_eff_lim # Calculating xsi eff lim
  section # Define section
  @t_section = @sec.bb.nil? && @sec.hh.nil? ? 0 : 1
  reinforcement # Define main reinforcement

  if @t_section == 1
    puts "\nIs T-section ledge stretched? (Upside down T-section) Y/N"
    print 'Y/N: '
    @ledge = gets.chomp.downcase
    @ledge = false if @ledge == 'y'
    @ledge = true if @ledge == 'n'
  else
    @ledge = true
  end

  # Assuming false T-section
  @x_eff = @ledge ? ((@as1 * (@stl.fyd / 10)) / (@sec.b * (con_par(0) / 10))) : ((@as1 * (@stl.fyd / 10)) / (@sec.bb * (con_par(0) / 10)))

  # Verifying T-section
  @x_eff = (((@as1 * (@stl.fyd / 10)) - ((@sec.b - @sec.bb) * @sec.h * (con_par(0) / 10))) / (@sec.bb * (con_par(0) / 10))) if @x_eff > @sec.h

  # Calculating compression zone
  @xsi_eff = @x_eff / @d
  @xsi_eff = @xsi_eff_lim if @xsi_eff > @xsi_eff_lim
  @ni_eff = @xsi_eff * (1 - 0.5 * @xsi_eff)

  # Calculating resistance
  if @t_section.zero? || (@t_section == 1 && @x_eff <= @sec.h)
    @mrd = ((@ni_eff * (@d**2) * @sec.b * (con_par(0) / 10)) / 100)
  else
    @fc1 = ((@sec.b - @sec.bb) * @sec.h * (con_par(0) / 10))
    @fc2 = (@x_eff * (@sec.bb * (con_par(0) / 10)))
    @zc1 = ((@d - (@sec.h / 2)) / 100)
    @zc2 = ((@d - (@x_eff / 2)) / 100)
    @mrd = ((@fc1 * @zc1) + (@fc2 * @zc2))
  end
  puts "\nSection resistance MRd = #{@mrd} kNm"
end
