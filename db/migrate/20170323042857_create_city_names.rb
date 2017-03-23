class CreateCityNames < ActiveRecord::Migration
  def change
    create_table :city_names do |t|
      t.string :city

      t.timestamps null: false
    end
  end
end
