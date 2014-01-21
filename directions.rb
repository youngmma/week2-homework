# ### directions.rb
# A user should be provided with two input prompts.
# A user can enter any origin address and any destination address.
# The program should return the total traveling distance in miles and the total travel time in hours and minutes.

# Use the the <a
# href='https://developers.google.com/maps/documentation/directions/'>Google
# Directions JSON API</a> to retrieve travel data.

# Required parameters

# 1) origin — The address or textual latitude/longitude value from which you wish to calculate directions. If you pass an address as a string, the Directions service will geocode the string and convert it to a latitude/longitude coordinate to calculate directions. If you pass coordinates, ensure that no space exists between the latitude and longitude values.
# 2) destination — The address or textual latitude/longitude value from which you wish to calculate directions. If you pass an address as a string, the Directions service will geocode the string and convert it to a latitude/longitude coordinate to calculate directions. If you pass coordinates, ensure that no space exists between the latitude and longitude values.
# 3) sensor — Indicates whether or not the directions request comes from a device with a location sensor. This value must be either true or false.


require 'open-uri'
require 'json'
require 'benchmark'


puts "Please enter a origin address: "
origin = gets.chomp

puts "Please enter a destination address: "
destination = gets.chomp

#replace any street var whitespace with +
origin.gsub! /\s+/, '+'
destination.gsub! /\s+/, '+'

@url = "http://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&sensor=false"

uri = URI.parse(@url)
json = uri.open.read

parsed_json = JSON.parse(json)

# return the total traveling distance in miles and the total travel time in hours and minutes
# By default, API text uses the unit system of the origin's country or region.
# http://stackoverflow.com/questions/3419050/ruby-select-a-hash-from-inside-an-array

distance = parsed_json["routes"].first["legs"].first["distance"].values_at("text")
duration = parsed_json["routes"].first["legs"].first["duration"].values_at("text")

# OTHER METHOD TO RETREIVE INFO (not efficient)
# response1 = parsed_json["routes"].first["legs"]
# response2 = response1.find {|x| x["distance"]}
# distance = response2["distance"].first["text"]#.values_at("text")
# duration = response2["duration"].first["text"]#.values_at("text")

puts "Total travel time: " + duration.to_s.to_s.gsub('"', '') .to_s.gsub('[', '').to_s.gsub(']', '')
puts "Traveling distance: " + distance.to_s.to_s.gsub('"', '').to_s.gsub('[', '').to_s.gsub(']', '')