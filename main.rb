require_relative 'constants.rb'
start = Indexer.new

puts 'Welcome to concrete characteristics database!'
print 'What class of concrete You want to look up for? (ex. C16/20, B37, etc.)
Class:'
loop do
  str = gets.chomp
  break if str.casecmp('quit').zero?
  while start.index(str).nil?
    print "\nThere's no such class! Try again!\nClass:"
    str = gets.chomp
  end
  ix = start.index(str)
  Informer.new.info(ix)
  puts "\nWant to chceck another? Which one? If no, type QUIT"
end
