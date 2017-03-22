class CitiesController < ApplicationController
  def new
    @city=City.new()
  end

  def create
    @city = City.new(city_params)
    if @city.save!
      redirect_to cities_path
    else
      redirect_to new_city_path
    end
  end

  def index
    @cities=City.all
  end
  def city_params
    params.require(:city).permit(:name)
  end
end
