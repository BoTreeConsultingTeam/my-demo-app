class Booking < ActiveRecord::Base
  validates :date, presence: true
  belongs_to :customer
  belongs_to :cleaner
end
