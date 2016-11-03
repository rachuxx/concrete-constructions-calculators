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
