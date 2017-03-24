class RemoveCleaningCompleteFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :cleaning_complete, :datetime
  end
end
