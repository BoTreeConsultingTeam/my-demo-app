class AddCleaningStartToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :cleaning_start, :datetime
  end
end
