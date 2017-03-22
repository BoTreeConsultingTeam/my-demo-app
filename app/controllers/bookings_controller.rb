class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @cities = City.all
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @cities = City.all
    @booking = Booking.new(customer_city_id: params["city_id"])

    @booking.cleaning_complete = DateTime.new(params[:booking]["date(1i)"].to_i,
                            params[:booking]["date(2i)"].to_i,
                            params[:booking]["date(3i)"].to_i,
                            params[:booking]["date(4i)"].to_i,
                            params[:booking]["date(5i)"].to_i)
    @cleaners = City.find(@booking.customer_city_id).cleaners
    @cleaners.each do |cleaner|
      respond_to do |format|
        if cleaner.date.nil? || cleaner.date == @booking.cleaning_complete
          cleaner.update_attribute(:date, @booking.cleaning_complete)
          @booking.cleaner_id = cleaner.id
            if @booking.save
              format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
              format.json { render :show, status: :created, location: @booking }
              break
            end
        else
          format.html { render :new }
          format.json { render json: @booking.errors, status: :unprocessable_entity }
        end
      end
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
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.html { redirect_to customer_path(@customer), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:cleaning_start, :city, :cleaning_complete)
    end
end
