class CleanersController < ApplicationController
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]
  before_action :set_all_city, only: [:new, :edit, :create]
  before_action :authenticate_admin

  def index
    @cleaners = Cleaner.all
  end

  def show
  end

  def new
    @cleaner = Cleaner.new
  end

  def edit
  end

  def create
    @cleaner = Cleaner.new(cleaner_params)
    respond_to do |format|
      if @cleaner.save
        params[:city_ids].each do |city_id|
          CleanerCity.create(cleaner_id: @cleaner.id, city_id: city_id)
        end
        format.html { redirect_to @cleaner, notice: 'Cleaner was successfully created.' }
        format.json { render :show, status: :created, location: @cleaner }
      else
        format.html { render :new }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cleaner.update(cleaner_params)
        format.html { redirect_to @cleaner, notice: 'Cleaner was successfully updated.' }
        format.json { render :show, status: :ok, location: @cleaner }
      else
        format.html { render :edit }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
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
    end

    def cleaner_params
      params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :city_ids, :email)
    end

end
