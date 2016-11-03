require 'pry'

types = ['beam']

# Start of user-program interaction
puts 'Welcome to reinforced concrete constructions calculator!'
puts 'What kind of element You want to calculate?'
puts 'As for now, I can help You with: beams (BEAM)'
print 'I want to calculate: '
str = gets.chomp.downcase
until types.include?(str) || str.casecmp('quit').zero?
  puts 'I don\'t know that type. Try again. Psst... U can always type QUIT'
  str = gets.chomp
end

# Script starter
case str
when 'beam' then
  require_relative 'beam.rb'
end
