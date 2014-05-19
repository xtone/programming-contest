#!/usr/bin/env ruby

unless ARGV[0]
  exit
end

file = File.open(ARGV[0], 'r')
readlines = file.readlines

case_count = readlines[0].to_i

puts "case_count: " + case_count.to_s

case_count.times do |i|
  cars_count = readlines[i*2 + 1].to_i
  cars_line = readlines[i*2 + 2].chomp

  puts "Case #" + i.to_s
  #puts i.to_s + " " + cars_count.to_s + " " + cars_line

  cars = cars_line.split(' ', cars_count)
  #p cars
end
