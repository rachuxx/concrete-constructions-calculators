require_relative 'constants.rb'
test = Indexer.new

puts 'Welcome to Concrete characteristics databe!'
print "What class of concrete You want to look up for? (ex. C16/20, B37, etc.)\nClass: "
loop do
  str = gets.chomp
  break if str.downcase == 'quit'
  ix = test.index(str)
  Loger.new.info(ix)
  puts "\nWant to chceck another? Which one? If no, type QUIT"
end
