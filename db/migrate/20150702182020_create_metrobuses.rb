class CreateMetrobuses < ActiveRecord::Migration
  def change
    create_table :metrobuses do |t|
      t.string :stop_name
      t.string :stop_code
      t.float :stop_latitude
      t.float :stop_longitude

      t.timestamps null: false
    end
  end
end