class AddDateToCleaner < ActiveRecord::Migration
  def change
    add_column :cleaners, :date, :datetime
  end
end
