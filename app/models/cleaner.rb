class Cleaner < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :quality_score, length: { in: 0..5 }

    has_many :bookings
    has_many :customers, through: :bookings
    has_many :cleaner_cities
    has_many :cities, through: :cleaner_cities
end
