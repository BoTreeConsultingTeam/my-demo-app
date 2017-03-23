class CreateConnection1s < ActiveRecord::Migration
  def change
    create_table :connection1s do |t|
      t.cleaner :references
      t.city_name :references

      t.timestamps null: false
    end
  end
end
