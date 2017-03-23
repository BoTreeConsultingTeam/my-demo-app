class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :session_checking
  before_action :select_city, only: [:new,:create,:edit,:get_city_wise_cleaner]
  before_action :admin_only, only: [:new,:edit]
  # GET /bookings
  # GET /bookings.json
  def index
    if current_admin
      @bookings = Booking.all
    else
      @bookings = Booking.where(customer_id:session[:customer])
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    begin
    @booking = Booking.new
    @booking.customer_id = session[:customer]
    @cleaner_id = params[:cleaner]
    @booking.cleaner_id = @cleaner_id
    @booking.city_id = City.find_by(name: params[:city_name].keys).id
    @datetime = Time.new(params[:booking].values[0],params[:booking].values[1],params[:booking].values[2],params[:booking].values[3],params[:booking].values[4],params[:booking].values[5])
    @booking.datetime = @datetime
    if check_date_conflict(@datetime,@cleaner_id)
      if @booking.save
      # BookingMailer.booking_cleaner_email(@booking).deliver_now
        respond_to do |format|
          format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
          format.json { render :show, status: :created, location: @booking }
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "This Cleaner already assign on This date or time"
      render :new
    end
   rescue
     flash[:notice] = "In valid Data"
     render :new
   end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_city_wise_cleaner
    @cleaner1 = CitiesCleaner.where(city_id:City.find_by(name:params[:city]))
    @cleaner = []
    @cleaner1.each do |cl|
      @cleaner << cl.cleaner
    end
    @booking = Booking.new
    render :new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # select city for new or create
    def select_city
      @city = City.all
    end

    def booking_params
      params.require(:booking).permit(:cleaner_id)
    end

    def check_date_conflict(datetime,cleaner)
      @book = Booking.where(datetime:datetime-3.hours..datetime+3.hours,cleaner_id:cleaner)
      @book.count == 0
    end
end
