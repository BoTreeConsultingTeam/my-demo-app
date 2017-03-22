class Cleaner < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :quality_score, presence: true
  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :quality_score, length: { in: 0..5 }

    has_many :cleaner_cities
    has_many :cities, through: :cleaner_cities
end
