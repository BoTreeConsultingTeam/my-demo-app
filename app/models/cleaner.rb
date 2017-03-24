class Cleaner < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  ONLY_ALPHA_REGEX = /[a-zA-Z]+$/
  has_and_belongs_to_many :cities, dependent: :destroy
  has_many :customers, through: :bookings
  validates_format_of :first_name, :last_name, with: ONLY_ALPHA_REGEX, message: 'is invalid', multiline: true
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: EMAIL_REGEX, message: 'is invalid'
  scope :all_cleaners, -> { all }
end
