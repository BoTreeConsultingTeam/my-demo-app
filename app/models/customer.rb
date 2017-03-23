class Customer < ActiveRecord::Base
  has_many :bookings, :foreign_key => "booking_id"
  has_many :cleaners, through: :bookings, :source => :cleaner

  validates :first_name, :last_name, presence: true
  validates :phone_number,:numericality => true,
            :length => { :minimum => 10, :maximum => 10 },
             :allow_blank => true

end
