class Customer < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number,presence: true
  validates :date, presence: true
  validates :city_id, presence: true
  validates :phone_number,:presence => true,
                   :numericality => true,
                   :length => { :minimum => 10, :maximum => 15 }
  attr_accessor :date,:city_id

end
