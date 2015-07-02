class TransitController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    lat, long = params[:user_latitude].to_f, params[:user_longitude].to_f
    station = StationApi.new
    bike = BikeshareApi.new
    metrobus = MetrobusApi.new
    @s = station.nearby_station_information lat, long
    @b = bike.nearby_bikeshare_information lat, long
    @m = metrobus.nearby_stop_information lat, long
  end

end