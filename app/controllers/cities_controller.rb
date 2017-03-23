class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  def index
    @cities = City.all
  end

  def show
  end

  def destroy
    @city.destroy
    redirect_to action: 'index'
  end

  def edit
  end

  def update
    if @city.update(set_params)
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(set_params)
    if @city.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private

  def set_params
    params.require(:city).permit(:city_name)
  end

  def set_city
    @city = City.includes(:bookings, :cleaners).find(params[:id])
  end
end
