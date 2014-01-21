# ### weather.rb
# A user should be provided with an input prompt.
# A user can enter any address and the program should return the temperature in Fahrenheit.

# Use the <a
# href='http://openweathermap.org/API'>OpenWeatherMap JSON API</a> to pull weather data based on the user input. 



require 'open-uri'
require 'json'

puts "Enter a full street address (street number, street name, street suffix, city, state, zip code): "
address_string = gets.chomp

#replace any street var whitespace with +
address_string.gsub! /\s+/, '+'

#FIRST, get lat and lng info for the address entered by the user
@url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{address_string}&sensor=false"

uri = URI.parse(@url)
json = uri.open.read
parsed_json = JSON.parse(json)

lat, lng = parsed_json["results"].first["geometry"]["location"].values_at("lat", "lng")

#SECOND, find temperature info using the lat, lng info found
address = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat.to_s}&lon=#{lng.to_s}"
       
uri = URI.parse(address)
json = uri.open.read
parsed_json = JSON.parse(json)

#conversion from Kevin to F
temp_K = parsed_json["main"]["temp"]
temp_F = (temp_K - 273.15) * 1.8 + 32

puts temp_F.round(1).to_s + "F"
