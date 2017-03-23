class CreateCitiesCleaners < ActiveRecord::Migration
  def change
    create_table :cities_cleaners do |t|
      t.references :city, index: true, foreign_key: true
      t.references :cleaner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
