class CreateCleanerCities < ActiveRecord::Migration
  def change
    create_table :cleaner_cities do |t|
      t.integer :city_id
      t.integer :cleaner_id

      t.timestamps null: false
    end
  end
end
