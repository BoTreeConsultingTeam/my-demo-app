class AddColumnToCleaners < ActiveRecord::Migration
  def change
    add_column :cleaners, :email_confirmed, :boolean, default: false
    add_column :cleaners, :confirm_token, :string
  end
end
