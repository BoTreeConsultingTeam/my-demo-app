class City < ActiveRecord::Base
  has_and_belongs_to_many :cleaners
  has_many :bookings
  validates :name,presence:true
end
