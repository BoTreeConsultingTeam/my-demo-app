class CitiesController < ApplicationController
  before_action :set_city, only: [:edit,:update,:destroy,:show]
  def index
    @cities = City.all
  end

  def new
    @city = City.new
  end

  def create
    # byebug
    @city = City.new(params_city)
    if @city.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @city.update(params_city)
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end


  def destroy
    @city.destroy
    redirect_to action: 'index'
  end

  private

  def params_city
    params.require(:city).permit(:name)
  end

  def set_city
    @city = City.find(params[:id])
  end
end
