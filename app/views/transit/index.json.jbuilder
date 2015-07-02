json.location do
    json.stations @s do |station|
      json.(station, :station_name, :line_1, :line_2, :line_3, :line_4, :station_latitude, :station_longitude, :station_distance, :upcoming_trains)
    end
    json.metrobuses @m do |metrobus|
      json.(metrobus, :stop_name, :stop_latitude, :stop_longitude, :stop_distance, :upcoming_buses)
    end
    json.bikeshares @b do |bikeshare|
      json.(bikeshare, :bikeshare_name, :bikeshare_latitude, :bikeshare_longitude, :bikeshare_distance, :availability)
    end
end