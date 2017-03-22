class Customer < ActiveRecord::Base

  attr_accessor :city, :date
  has_many :bookings
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, allow_blank: true, uniqueness: true, format: { :with =>  /\d[0-9]\)*\z/  },  :length => { :minimum => 10, :maximum => 15 }

end
