class AddDateToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :date, :datetime
  end
end
