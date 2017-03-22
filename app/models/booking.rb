class Booking < ActiveRecord::Base

  validates :customer_city_id, :presence => true
  validates :cleaning_start, :presence => true

end
