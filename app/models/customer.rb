class Customer < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence:true, uniqueness: true
  attr_accessor :city
end
