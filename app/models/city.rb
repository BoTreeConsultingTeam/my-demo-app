class City < ActiveRecord::Base
  validates :name, presence: { message: "must be given please" }, uniqueness: { case_sensitive: false , message: "City with the same name already exist" }
  has_one :city
  has_many :cleaner_cities
  has_many :cleaners, through: :cleaner_cities

end
