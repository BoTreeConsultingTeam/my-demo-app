class CitiesController < ApplicationController
  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to city_path(@city)
    else
      render 'new'
    end
  end
  def show
    @city = City.find(params[:id])
  end
  def edit
    @city = City.find(params[:id])
  end
  def update
    if @city.update(city_params)
      redirect_to 'show'
    else
      render 'edit'
    end
  end
  def destroy
    @city = City.find(params[:id])
    if @city.destroy
      redirect_to @city
    else
      render @city
    end
  end
  def index
    @cities = City.all
  end
  private
  def city_params
    params.require(:city).permit(:name)
  end
end
