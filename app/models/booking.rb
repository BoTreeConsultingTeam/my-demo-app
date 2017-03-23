class Booking < ActiveRecord::Base

  belongs_to :cleaner
  belongs_to :city
  belongs_to :customer

  validates :customer_city_id, :presence => true
  validates :cleaning_start, :presence => true

end
