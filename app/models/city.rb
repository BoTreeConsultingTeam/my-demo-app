class City < ActiveRecord::Base
  has_and_belongs_to_many :cleaners, dependent: :destroy
  has_many :bookings
  validates :city_name, presence: true, uniqueness: true
  validates_format_of :city_name, with:  /[a-zA-Z]+$/, message:  "is invalid", multiline: true
end
