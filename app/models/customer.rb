class Customer < ActiveRecord::Base
  has_many :bookings
  has_many :cleaners, through: :bookings
  validates_format_of :first_name, :last_name, with:  /[a-zA-Z]+$/, message:  "is invalid", multiline: true
  validates :first_name, :last_name, :phone_number, presence: true
  validates :phone_number, numericality: { message: "%{value} seems wrong" }, length: {is:10, message: "Invalid"}
  validates :phone_number, uniqueness: true
end
