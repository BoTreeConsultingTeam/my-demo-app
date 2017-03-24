class Booking < ActiveRecord::Base

  belongs_to :cleaner
  belongs_to :city, class_name: "City", foreign_key: "customer_city_id"
  belongs_to :customer

  validates :customer_city_id, :presence => true
  validates :cleaning_start, :presence => true

end
