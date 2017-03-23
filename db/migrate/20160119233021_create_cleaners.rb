class CreateCleaners < ActiveRecord::Migration
  def change
    create_table :cleaners do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :quality_score

      t.timestamps null: false
    end
  end
end
