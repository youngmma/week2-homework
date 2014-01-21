# A user should be provided with an input prompt.
# A user can enter any full street address (street number, street name, street suffix, city, state, zip code) and the program should return latitude and longitude coordinates.

# Use the <a href='https://developers.google.com/maps/documentation/geocoding/'>Google Geocoding JSON API</a> to convert the address to latitude and longitude.

# Required parameters by API
# address — The address that you want to geocode. 
# sensor — Indicates whether or not the geocoding request comes from a device with a location sensor. This value must be either true or false

require 'open-uri'
require 'json'

puts "Please enter a full street address (street number, street name, street suffix, city, state, zip code): "
address_string = gets.chomp

#replace any street var whitespace with +
address_string.gsub! /\s+/, '+'

# Ref. used:
# http://stackoverflow.com/questions/6325351/easy-way-to-access-hashes-from-within-arrays-with-ruby

@url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{address_string}&sensor=false"

uri = URI.parse(@url)
json = uri.open.read

parsed_json = JSON.parse(json)

lat, lng = parsed_json["results"].first["geometry"]["location"].values_at("lat", "lng")

puts "Latitude: " + lat.to_s 
puts "Longitude: " + lng.to_s