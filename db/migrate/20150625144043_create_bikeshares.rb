class CreateBikeshares < ActiveRecord::Migration
  def change
    create_table :bikeshares do |t|
      t.string "name"
      t.float "bikeshare_latitude"
      t.float "bikeshare_longitude"

      t.timestamps null: false
    end
  end
end
