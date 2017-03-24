class Customer < ActiveRecord::Base

  has_many :bookings, dependent: :destroy

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone_number, :presence => true, :uniqueness => true, :length => { :minimum => 10, :maximum => 10 }

end
