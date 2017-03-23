class Booking < ActiveRecord::Base
  belongs_to :cleaners, :class_name => "Cleaner"
  belongs_to :customers, :class_name => "Customer"

  validates :customer_id, :cleaner_id, :date, presence: true
end
