class CitiesController < ApplicationController
  def new
    @city = City.new
  end

  def index
    @cities = City.all
  end

  def create
  @city = City.new(city_params)
    if @result = @city.save
    else
      render :action => "index"
    end
  end
end

  def city_params
    params.require(:city_name).permit(:city_name)
  end

  def set_city
    @city = City.find(params[:id])
  end

  def create_city
    @city = City.new
  end
end
