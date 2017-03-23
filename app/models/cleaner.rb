class Cleaner < ActiveRecord::Base

  has_many :cities, through: :cleaner_cities
  has_many :cleaner_cities, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, presence: {message: "must be required!"} , uniqueness: { case_sensitive: false, message: "Email already exist"  }
  validates :quality_score, :presence => true, :inclusion => 0.0..5.0

end
