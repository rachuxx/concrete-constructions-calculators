require 'pry'
# Constants module
module Const
  # Concrete characterictics
  CONCRETE_VALUES = {
    fck: [12, 16, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90],
    fckc: [15, 20, 25, 30, 37, 45, 50, 55, 60, 67, 75, 85, 95, 105],
    fcm: [20, 24, 28, 33, 38, 43, 48, 53, 58, 63, 68, 78, 88, 98],
    fctm:
      [1.6, 1.9, 2.2, 2.6, 2.9, 3.2, 3.5, 3.8, 4.1, 4.2, 4.4, 4.6, 4.8, 5.0],
    fctk05:
      [1.1, 1.3, 1.5, 1.8, 2.0, 2.2, 2.5, 2.7, 2.9, 3.0, 3.1, 3.2, 3.4, 3.5],
    fctk95:
      [2.0, 2.5, 2.9, 3.3, 3.8, 4.2, 4.6, 4.9, 5.3, 5.5, 5.7, 6.0, 6.3, 6.6],
    ecm: [27, 29, 30, 31, 32, 34, 35, 36, 37, 38, 39, 41, 42, 44],
    ec1:
      [1.8, 1.9, 2.0, 2.1, 2.2, 2.25, 2.3, 2.4, 2.45, 2.5, 2.6, 2.7, 2.8,
       2.8],
    ecu1:
      [3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.2, 3.0, 2.8, 2.8, 2.8],
    ec2:
      [2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.2, 2.3, 2.4, 2.5, 2.6],
    ecu2:
      [3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.1, 2.9, 2.7, 2.6, 2.6],
    n:
      [2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 1.75, 1.6, 1.45, 1.4,
       1.4],
    ec3:
      [1.75, 1.75, 1.75, 1.75, 1.75, 1.75, 1.75, 1.75, 1.75, 1.8, 1.9, 2.0,
       2.2, 2.3],
    ecu3:
      [3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.1, 2.9, 2.7, 2.6, 2.6]
  }.freeze
  # Concrete characteristics' units
  CONCRETE_UNITS = {
    fck: 'MPa',
    fckc: 'MPa',
    fcm: 'MPa',
    fctm: 'MPa',
    fctk05: 'MPa',
    fctk95: 'MPa',
    ecm: 'GPa',
    ec1: '‰',
    ecu1: '‰',
    ec2: '‰',
    ecu2: '‰',
    n: '‰',
    ec3: '‰',
    ecu3: '‰'
  }.freeze
  # Materials' partial factors
  PARTIAL_FACTORS = {
    steel: 1.15,
    conc: 1.5,
    steel_comp: 1.15
  }.freeze
  C_MIN_DUR = {
    '1' => [10, 10, 10, 15, 20, 25, 30],
    '2' => [10, 10, 15, 20, 25, 30, 35],
    '3' => [10, 10, 20, 25, 30, 35, 40],
    '4' => [10, 15, 25, 30, 35, 40, 45],
    '5' => [15, 20, 30, 35, 40, 45, 50],
    '6' => [20, 25, 35, 40, 45, 55, 55]
  }.freeze
end

# Concrete info
class Informer
  def info(ix)
    Const::CONCRETE_VALUES.each do |characterictic, value|
      puts "#{characterictic}: #{value[ix]} "
      + Const::CONCRETE_UNITS[characterictic]
    end
  end
end

# Indexing class
class Indexer
  attr_reader :ix
  def index(con_cl)
    ix1 = con_cl.gsub(/\D/, '')
    l1 = ix1[0..1].to_i
    l2 = ix1[2..3].to_i
    Const::CONCRETE_VALUES[:fckc].index([l1, l2].max)
  end
end

# Method which gets concrete characteristics
def con_class_index
  start = Indexer.new
  puts 'What\'s the concrete class?'
  con_cl = gets.chomp
  while start.index(con_cl).nil?
    print "\nThere's no such class! Try again!\nClass:"
    con_cl = gets.chomp
  end
  start.index(con_cl)
  # Informer.new.info(con_ix)
end

# Method which returns values of given param
def con_par(par, con_ix)
  Const::CONCRETE_VALUES.values[par][con_ix] / Const::PARTIAL_FACTORS[:conc]
end

# Method which calculates concrete cover
def con_cover
  puts 'User input for cover? Y/N'
  test = gets.chomp.downcase
  if test == 'n'
    puts 'What\'s maximal given diameter of main reinforcement bars? [mm]'
    fi = gets.chomp.to_f
    puts 'Choose class of exposition:'
    puts '1-X0; 2-XC1; 3-XC2/XC4; 4-XC4; 5-XD1/XS1; 6-XD2/XS2; 7-XD3/XS3'
    print 'Class: '
    cl_exp = gets.chomp.to_i
    puts "\nChoose class of construction:"
    puts '1-S1; 2-S2; 3-S3; 4-S4; 5-S5; 6-S6'
    print 'Class: '
    cl_const = gets.chomp.to_i.to_s
    c_min_dur = Const::C_MIN_DUR[cl_const][cl_exp - 1]
    c_min_b = fi
    c_min = [c_min_b, c_min_dur, 10].max
    puts "\nCover deviation? Default: 10"
    print 'Deviation: '
    d_c_dev = gets.chomp.to_f
    c_min + d_c_dev
  else
    puts 'What\'s the nominal concrete cover?'
    print 'Cover [mm]: '
    gets.chomp.to_f
  end
end

# def xsi_eff_lim(fyk, con_ix)
#   0.8 * (Const::CONCRETE_VALUES[:ecu1][con_ix]/(Const::CONCRETE_VALUES[:ecu1][con_ix]+(fyk/1.15)/Const::CONCRETE_VALUES[:ecu1][con_ix]
# end
