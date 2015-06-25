json.location do
    json.stations @w do |station|
      json.(station, :station_name, :line_1, :line_2, :line_3, :line_4, :station_distance, :upcoming)
    end
    json.bikeshares @b do |bikeshare|
      json.(bikeshare, :name, :bikeshare_distance, :availability)
    end
end