class City < ActiveRecord::Base
  has_many :cleaner_cities
  has_many :cleaners, through: :cleaner_cities
end
