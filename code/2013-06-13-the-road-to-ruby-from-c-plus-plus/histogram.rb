# Histogram with Ruby
#//  {run}     --> ruby histogram.rb

sentence    = "this test of is a a this test phrase of is a of a of a test";

puts "\nTest sentence for histogram is:\n\t#{sentence}\n\n"

words       = sentence.split(" ")

frequencies = Hash.new(0)
words.each {|w| frequencies[w] += 1}

frequencies = frequencies.sort_by {|a,b| b}
frequencies.reverse!

puts "Frequency table of sentence is:\n\n"

frequencies.each {|key,value| puts "#{key}, count = #{value}"}

puts "\nRuby program is DONE.\n\n"