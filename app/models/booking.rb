class Booking < ActiveRecord::Base

  belongs_to :customer
  belongs_to :cleaner

  validates :date, presence: true

end
