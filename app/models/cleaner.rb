class Cleaner < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
  QUALITY_REGEX = /\A\d+(?:\.\d{0,2})?\z/
  has_many :bookings
  has_and_belongs_to_many :cities
  has_many :customers,through: :bookings

  # valition for Cleaner data in model

  validates_presence_of :email,:last_name,:first_name,:quality_score
  validates :email, format: { with: EMAIL_REGEX, message: ': Invalid Email Address'}
  validates :quality_score, format: { with: QUALITY_REGEX, message: ': Invalid Quality score' }, :numericality => {:greater_than => 0, :less_than => 5.1}


end
