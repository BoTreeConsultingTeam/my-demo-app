class Cleaner < ActiveRecord::Base

  has_many :cleaners_cities, dependent: :destroy
  has_many :booking, dependent: :destroy
  has_many :cities, through: :cleaners_cities

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :quality_score, presence: true
end
