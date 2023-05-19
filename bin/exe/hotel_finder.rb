#!/usr/bin/env ruby

require 'hotel_finder'

print "Enter the hotel name: "
hotel_name = gets.chomp

finder = HotelFinder::Finder.new(hotel_name)
urls = finder.match

urls.each do |source, url|
  puts "#{url} for #{source.capitalize}:" if url
end

