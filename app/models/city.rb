class City < ActiveRecord::Base
  has_many :cleaners , through: :cleaner_cities
  has_many :cleaner_cities
  validates :name , presence: {message: "must be required!"} , uniqueness: { case_sensitive: false, message: "City already exist"  }
end
