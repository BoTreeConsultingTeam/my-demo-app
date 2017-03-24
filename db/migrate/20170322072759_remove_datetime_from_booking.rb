class RemoveDatetimeFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :datetime, :string
  end
end
