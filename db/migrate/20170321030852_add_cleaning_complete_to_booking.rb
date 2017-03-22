class AddCleaningCompleteToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :cleaning_complete, :datetime
  end
end
