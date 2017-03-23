class City < ActiveRecord::Base
  has_many :cleaner_cities, dependent: :destroy
  has_many :cleaners, through: :cleaner_cities
  has_many :bookings, dependent: :destroy

  validates :name, presence: { message: "must be given please" }, uniqueness: { case_sensitive: false , message: "City with the same name already exist" }

end
