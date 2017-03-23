class CityName < ActiveRecord::Base
  has_many :connection1s
  has_many :cleaners, :through => :connection1s, :source => :cleaner

end
