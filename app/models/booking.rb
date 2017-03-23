class Booking < ActiveRecord::Base
 belongs_to :customer
 belongs_to :cleaner
 belongs_to :city

 validates_presence_of :customer_id,:cleaner_id,:city_id,:datetime
 validate :before_current_date

  def before_current_date
    valid = datetime > DateTime.now
    valid
  end
end
