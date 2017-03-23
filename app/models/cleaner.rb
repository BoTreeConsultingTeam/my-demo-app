class Cleaner < ActiveRecord::Base
  has_many :bookings, :foreign_key => "booking_id"
    has_many :customers, :through => :bookings, :source => :customer
    has_many :connection1s, :foreign_key => "connection1_id", dependent: :destroy
    has_many :city_names, :through => :connection1s, :source => :city_name
    validates :first_name, :last_name, presence: true
    validates :quality_score, presence: true,
              :numericality => true,
              :numericality => { :greater_than => 0.0, :less_than => 5.0 }

end
