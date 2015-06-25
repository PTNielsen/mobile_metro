class ChangeStations < ActiveRecord::Migration
  def change 
    change_column :stations, :station_code,  :string
  end
end
