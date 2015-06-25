class TransitController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    wmata = WmataApi.new
    bike = BikeshareApi.new
    @w = wmata.nearby_station_information params[:user_latitude].to_f, params[:user_longitude].to_f
    @b = bike.nearby_bikeshare_information params[:user_latitude].to_f, params[:user_longitude].to_f
  end

end