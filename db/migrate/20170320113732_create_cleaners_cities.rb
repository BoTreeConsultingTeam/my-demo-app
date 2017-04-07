class CreateCleanersCities < ActiveRecord::Migration
  def change
    create_table :cleaners_cities do |t|
      t.integer :cleaner_id
      t.integer :city_id

      t.timestamps null: false
    end
  end
end
