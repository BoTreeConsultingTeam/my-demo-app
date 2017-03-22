class AddCustomerCityIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :customer_city_id, :integer
  end
end
