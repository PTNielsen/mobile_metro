require 'httparty'
require 'json'

class BikeshareApi

  include HTTParty
  base_uri 'https://www.capitalbikeshare.com/data/stations/bikeStations.xml'

  def populate_bikeshare_table
    b = BikeshareApi.get("")
    stations = b["stations"]["station"]
    stations.each do |s|
      Bikeshare.where({
        :name => s["name"],
        :bikeshare_latitude => s["lat"],
        :bikeshare_longitude => s["long"]
        }).first_or_create!
    end
  end

  def self.bikeshares_by_distance user_latitude, user_longitude
    bikeshare_haversine = []
    Bikeshare.all.each do |b|
      bd = (Haversine.distance(b.bikeshare_latitude, b.bikeshare_longitude, user_latitude, user_longitude)).to_mi
      bikeshare_haversine.push({
        :name => b.name,
        :bike_distance => bd
      })
    end
    bikeshare_haversine.sort_by { |i| i[:bike_distance] }
  end

  def self.realtime_bikes location
    b = BikeshareApi.get("")
    stations = b["stations"]["station"]
    bike_availability = stations.map { |n| n.values_at("name", "nbBikes", "nbEmptyDocks", "latestUpdateTime") }
    bikeshare_array = bike_availability.find { |bike| bike[0] == "#{location}"}
    realtime_bike = Hash[
      :bikeshare_name => bikeshare_array[0],
      :bikes_available => bikeshare_array[1],
      :empty_docks => bikeshare_array[2],
      :last_update => bikeshare_array[3]
    ]
  end

  def nearby_bikeshare_information user_latitude, user_longitude
    b = BikeshareApi.bikeshares_by_distance user_latitude, user_longitude
    bike_data_array = []
    b.first(3).each do |brs|
      bike_data = {}
      bike_data[:name] = brs[:name]
      bike_data[:bikeshare_distance] = brs[:bike_distance]
      bike_data[:availability] = BikeshareApi.realtime_bikes(brs[:name])
      bike_data_array.push bike_data
    end
    bike_data_array
  end

end