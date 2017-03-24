class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :destroy]
  before_action :set_all_city, only: [:create, :new]

  def index
    @bookings = Booking.all
  end

  def show
    if not current_admin.nil?
      @booking.customer_id = 48
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(customer_city_id: params["city_id"])
    @booking.cleaning_start = DateTime.new(params[:booking]["cleaning_start(1i)"].to_i, params[:booking]["cleaning_start(2i)"].to_i, params[:booking]["cleaning_start(3i)"].to_i, params[:booking]["cleaning_start(4i)"].to_i, params[:booking]["cleaning_start(5i)"].to_i)
    @cleaners = City.find(@booking.customer_city_id).cleaners
    if not current_admin.nil?
      @booking.customer_id = 48
    end
    @cleaners.each do |cleaner|
      if cleaner.date.nil? || cleaner.date <= @booking.cleaning_start
        cleaner.update_attribute(:date, @booking.cleaning_start + 2.hours )
        @booking.cleaner_id = cleaner.id
          if @booking.save
            redirect_to booking_path(@booking), notice: "Cleaner name: #{Cleaner.find(@booking.cleaner_id).first_name}"
            break
          else
            render 'new', notice: "Sorry"
            break
          end
      end
    end
    if @booking.cleaner_id.nil?
      render 'new', notice: "Sorry"
    end
  end

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

  def destroy
    @booking.destroy
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.html { redirect_to customer_path(@customer), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_all_city
      @cities = City.all
    end

    def booking_params
      params.require(:booking).permit(:cleaning_start, :city, :cleaning_complete)
    end

end
