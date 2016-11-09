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
  def index(con_cla)
    ix1 = con_cla.gsub(/\D/, '')
    l1 = ix1[0..1].to_i
    l2 = ix1[2..3].to_i
    Const::CONCRETE_VALUES[:fckc].index([l1, l2].max)
  end
end

# Method defining concrete
def con_cl
  start = Indexer.new
  print "\nConcrete: class "
  con_cla = gets.chomp
  while start.index(con_cla).nil?
    print "\nThere's no such class! Try again!\nClass:"
    con_cla = gets.chomp
  end
  @con_ix = start.index(con_cla)
  # Informer.new.info(con_ix)
end

# Method defining steel
def steel_cl
  puts "\nSteel: fyk [MPa]?"
  fyk = gets.chomp.to_f
  puts "\nSteel: Es [GPa]?"
  es = gets.chomp.to_f
  steel = Struct.new(:fyk, :es) do
    def fyd
      (fyk / 1.15)
    end
  end
  @stl = steel.new(fyk, es)
end

# Method which returns values of given param for concrete
def con_par(par)
  Const::CONCRETE_VALUES.values[par][@con_ix] / Const::PARTIAL_FACTORS[:conc]
end

# Method defining concrete cover
def con_cover
  puts "\nUser input for cover? Y/N"
  test = gets.chomp.downcase
  if test == 'n'
    puts "\nWhat's maximal given diameter of main reinforcement bars? [mm]"
    fi = gets.chomp.to_f
    puts "\nChoose class of exposition:"
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
    @c_nom = c_min + d_c_dev
  else
    puts "\nWhat\'s the nominal concrete cover?"
    print 'Cover [mm]: '
    @c_nom = gets.chomp.to_f
  end
end

# Method defining Xsi
def xsi_eff_lim
  ecu1 = (Const::CONCRETE_VALUES[:ecu1][@con_ix] / 1000)
  @xsi_eff_lim = (0.8 * (ecu1 / (ecu1 + (@stl.fyd / (@stl.es * (10**3))))))
end

# Method defining section
def section
  puts "\nSpecify section's dimensions in [cm]"
  puts 'Square - h b'
  puts 'T-section - h bf hf a'
  s = gets.chomp.split.map!(&:to_f)
  require 'ostruct'
  @sec = OpenStruct.new
  @sec.h = s[0]
  @sec.b = s[1]
  @sec.hf = s[2] unless s[2].nil?
  @sec.a = s[3] unless s[3].nil?
end

# Method defining reinforcement
def reinforcement
  print "\nNumber of main reinforcement As1 rows: "
  r = gets.chomp.to_i
  print "\nRows spacing [cm]: " if r > 1
  sp = gets.chomp.to_f if r > 1
  sp = 0 if r == 1
  print "\nRebars diameter [mm]: "
  @fi = gets.chomp.to_f
  print "\nNumber of rebars in a row: "
  n = gets.chomp.to_f
  print "\nDiameter of transverse reinforcement [mm]: "
  fi2 = gets.chomp.to_f
  @as1 = n * r * ((@fi / 20)**2) * Const::PI
  @a = (@c_nom / 10) + (fi2 / 10) + (@fi / 20) + ((n - 1) * (sp / 2))
  @d = @sec.h - @a
end
