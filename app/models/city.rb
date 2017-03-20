class City < ActiveRecord::Base
  has_many :cleaners_cities
  has_many :cleaner, through: :cleaners_cities

  enum status: [:Active, :Inactive]
end
