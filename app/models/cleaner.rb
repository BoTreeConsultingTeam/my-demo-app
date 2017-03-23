class Cleaner < ActiveRecord::Base
  has_many :cities , through: :cleaner_cities
  has_many :cleaner_cities

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :first_name , presence: true
  validates :last_name , presence: true
end
