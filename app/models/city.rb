class City < ActiveRecord::Base
  has_many :cleaners , through: :cleaner_cities
  has_many :cleaner_cities
  validates :name , presence: true ,uniqueness: true
end
