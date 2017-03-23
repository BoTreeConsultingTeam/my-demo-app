class RemoveDateFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :date, :string
  end
end
