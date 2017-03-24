class AddDetailToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :password, :string
  end
end
