class Cleaner < ActiveRecord::Base
  has_many :cleaners_cities
  has_many :cities, through: :cleaners_cities
end
