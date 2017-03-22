class RemoveCityFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :city, :string
  end
end
