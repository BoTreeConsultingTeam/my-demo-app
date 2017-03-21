class Customer < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_presence_of :phone_number
  has_many :bookings
  has_many :Cleaners, through: :bookings
end
