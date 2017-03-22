class Cleaner < ActiveRecord::Base
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, presence: {message: "must be required!"} , uniqueness: { case_sensitive: false, message: "Email already exist"  }
  validates :quality_score, :presence => true, :inclusion => 0.0..5.0

  has_many :cities, through: :cleaner_cities
  has_many :cleaner_cities

end
