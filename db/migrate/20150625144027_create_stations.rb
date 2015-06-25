class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer "station_code"
      t.string "station_name"
      t.string "line_1"
      t.string "line_2"
      t.string "line_3"
      t.string "line_4"
      t.float "station_latitude"
      t.float "station_longitude"

      t.timestamps null: false
    end
  end
end
