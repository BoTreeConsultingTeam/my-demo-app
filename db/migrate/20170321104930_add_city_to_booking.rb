class AddCityToBooking < ActiveRecord::Migration
  def change
    add_reference :bookings, :city, index: true, foreign_key: true
  end
end
