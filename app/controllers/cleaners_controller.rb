class CleanersController < ApplicationController
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]
  before_action :set_cities, only: [:new, :edit, :create, :update]
  before_action :authenticate_admin!

  def index
    @cleaners = Cleaner.all_cleaners
  end

  def show
    @cleaner_booking = Booking.where(cleaner_id: params[:id]).includes(:customer, :city)
  end

  def new
    @cleaner = Cleaner.new
  end

  def edit; end

  def create
    @cleaner = Cleaner.new(cleaner_params)
    if params[:city_ids].nil?
      flash[:cleaner_notice] = 'please select atleast one checkbox'
      redirect_to new_cleaner_path
    elsif @cleaner.save
      set_cleaners_city(params[:city_ids])
      redirect_to cleaners_path
    else
      render :new
    end
  end

  def update
    if params[:city_ids].nil?
      flash[:notice] = 'please select atleast one checkbox'
      redirect_to edit_cleaner_path
    elsif @cleaner.update(cleaner_params)
      CitiesCleaner.where(cleaner_id: @cleaner.id).destroy_all
      set_cleaners_city(params[:city_ids])
      redirect_to cleaners_path
    else
      render :edit
    end
  end

  def destroy
    @cleaner.destroy
    respond_to do |format|
      format.html { redirect_to cleaners_url, notice: 'Cleaner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cleaner
    @cleaner = Cleaner.find(params[:id])
    @selected_cities = CitiesCleaner.where(cleaner_id: params[:id]).select(:city_id)
  end

  def cleaner_params
    params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email)
  end

  def set_cities
    @cities = City.all
  end

  def set_cleaners_city(city_ids)
    city_ids.each do |city|
      CitiesCleaner.create(city_id: city, cleaner_id: @cleaner.id)
    end
  end
end
