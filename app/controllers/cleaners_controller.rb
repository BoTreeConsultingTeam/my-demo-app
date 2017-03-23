class CleanersController < ApplicationController
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  before_action :select_city, only: [:new, :edit, :create, :update]
  # GET /cleaners
  # GET /cleaners.json
  def index
    @cleaners = Cleaner.all
  end

  # GET /cleaners/1
  # GET /cleaners/1.json
  def show
  end

  # GET /cleaners/new
  def new
    @city = City.all
    @cleaner = Cleaner.new
  end

  # GET /cleaners/1/edit
  def edit
  end

  # POST /cleaners
  # POST /cleaners.json
  def create
    id_city = params[:city_ids]
    unless id_city.nil?
      @cleaner = Cleaner.new(cleaner_params)
      if @cleaner.save
        CitiesCleaner.add_city(@cleaner.id, params[:city_ids])
        respond_to do |format|
          format.html { redirect_to @cleaner, notice: 'Cleaner was successfully created.' }
          format.json { render :show, status: :created, location: @cleaner }
        end
      else
        render action: 'new'
      end
    else
      flash[:notice] = 'Please select At least one city'
      redirect_to action: 'new'
    end
  end

  # PATCH/PUT /cleaners/1
  # PATCH/PUT /cleaners/1.json
  def update
    id_city = params[:city_ids]
    unless id_city.nil?
      if @cleaner.update(cleaner_params)
        CitiesCleaner.where(cleaner_id: @cleaner.id).destroy_all
        CitiesCleaner.add_city(@cleaner.id, params[:city_ids])
        respond_to do |format|
          format.html { redirect_to @cleaner, notice: 'Cleaner was successfully updated.' }
          format.json { render :show, status: :ok, location: @cleaner }
        end
      else
        render 'edit'
      end
    else
      flash[:notice] = 'Without select City this operation not permit'
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @cleaner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cleaners/1
  # DELETE /cleaners/1.json
  def destroy
    @cleaner.destroy
    respond_to do |format|
      format.html { redirect_to cleaners_url, notice: 'Cleaner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleaner
      @cleaner = Cleaner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cleaner_params
      params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email)
    end

    def select_city
      @city = City.all
    end
end
