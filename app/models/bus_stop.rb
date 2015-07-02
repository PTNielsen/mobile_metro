class BusStop < ActiveRecord::Base
  validates_presence_of :stop_name, :stop_latitude, :stop_longitude
  validates_uniqueness_of :stop_name
end