class City < ActiveRecord::Base
  ONLY_ALPHA_REGEX = /[a-zA-Z]+$/
  has_and_belongs_to_many :cleaners, dependent: :destroy
  has_many :bookings
  validates :city_name, presence: true, uniqueness: true
  validates_format_of :city_name, with: ONLY_ALPHA_REGEX, message:  "is invalid", multiline: true
end
