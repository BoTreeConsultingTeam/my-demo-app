class City < ActiveRecord::Base
  has_many :cleaner_cities, dependent: :destroy
  has_many :cleaners, through: :cleaner_cities
  has_many :bookings

  validates :name, presence: true

end
