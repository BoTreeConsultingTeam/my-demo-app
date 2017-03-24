class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :destroy]

  def index
    @cities = City.all
  end

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
  end

  def edit
  end

  def update
    if @city.update(city_params)
      redirect_to 'show'
    else
      render 'edit'
    end
  end

  def destroy
    if @city.destroy
      redirect_to @city
    else
      render @city
    end
  end

  private

    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end

end
