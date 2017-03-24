class Cleaner < ActiveRecord::Base

  has_many :bookings
  has_many :cleaner_cities
  has_many :cities, through: :cleaner_cities

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :quality_score,presence: true, numericality: { only_integer: true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  validates :email, presence: :true, format: { with: /.+@.+\..+/i }

end
