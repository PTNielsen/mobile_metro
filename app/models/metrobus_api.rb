require 'httparty'
require 'json'

class MetrobusApi

  Token = ENV["wmata"]

  include HTTParty 
  base_uri "https://api.wmata.com"

  def populate_stop_table
    mb = MetrobusApi.get("/Bus.svc/json/jStops", query: {api_key: "#{Token}"})
    mb["Stops"].each do |s|
      Metrobus.where({
        :stop_code => s["StopID"],
        :stop_name => s["Name"],
        :stop_latitude => s["Lat"],
        :stop_longitude => s["Lon"]
      }).first_or_create!
    end
  end

  def self.stops_by_distance user_latitude, user_longitude
    stop_haversine = []
    Metrobus.all.each do |m|
      md = (Haversine.distance(m.stop_latitude, m.stop_longitude, user_latitude, user_longitude)).to_mi
      stop_haversine.push({
        :stop_code => m.stop_code,
        :stop_name => m.stop_name,
        :stop_latitude => m.stop_latitude,
        :stop_longitude => m.stop_longitude,
        :stop_distance => md
      })
    end
    stop_haversine.sort_by { |m| m[:stop_distance] }
  end

  def self.realtime_stop code
    rb = MetrobusApi.get("/NextBusService.svc/json/jPredictions", query: {api_key: "#{Token}", StopID: "#{code}"})
    realtime_buses = rb["Predictions"].map { |n| n.values_at("RouteID", "DirectionText", "Minutes") }
    realtime_buses = realtime_buses.map { |bus| Hash[
      :route_id => bus[0], 
      :direction_text => bus[1], 
      :min => bus[2]
      ] }
    realtime_buses.first(5)
  end  

  def nearby_stop_information user_latitude, user_longitude
    metrobus = MetrobusApi.stops_by_distance user_latitude, user_longitude
    bus_data_array = []
    metrobus.first(3).each do |mb|
      bus_data = {}
      bus_data[:stop_name] = mb[:stop_name]
      bus_data[:stop_latitude] = mb[:stop_latitude]
      bus_data[:stop_longitude] = mb[:stop_longitude]
      bus_data[:stop_distance] = mb[:stop_distance]
      bus_data[:upcoming_buses] = MetrobusApi.realtime_stop(mb[:stop_code])
      bus_data_array.push bus_data
    end
    bus_data_array
  end

end