class Customer < ActiveRecord::Base
  has_many :bookings
  has_many :cleaners,through: :bookings
  validates_presence_of :first_name, :last_name, :password, :phone_number
  validates :phone_number, format: { with: /\d{10}/, message: ': Invalid phone number'}
  validates :phone_number, uniqueness: true 
end
