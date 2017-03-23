class CitiesCleaner < ActiveRecord::Base
  belongs_to :cleaner
  belongs_to :city

  def self.add_city(id,id_city)
    id_city = id_city.map(&:to_i)
    city_id_arr = City.where(id: id_city)
    city_id_arr.each do |city|
      CitiesCleaner.create(cleaner_id: id, city_id:city.id)
    end
  end
end
