class AddCityToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :city, :string
  end
end
