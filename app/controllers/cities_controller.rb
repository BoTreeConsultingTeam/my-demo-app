class CitiesController < ApplicationController
  before_action :authenticate_admin
  def new
    @city=City.new()
  end

  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to cities_path, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @cities=City.all
  end
  def destroy
    @city=City.find(params[:id])
    if @city.destroy
      redirect_to cities_path
    end
  end
  def city_params
    params.require(:city).permit(:name)
  end
end
