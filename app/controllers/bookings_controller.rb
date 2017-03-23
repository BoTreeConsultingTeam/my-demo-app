class BookingsController < ApplicationController

  def index
    if current_admin.nil?
      @bookings = Booking.includes(:city, :cleaner, :customer).where(customer_id: session[:customer_id])
    else
      redirect_to admins_path
    end
  end

  def show
  end

  def new
    if current_admin.nil?
      @booking = Booking.new
      @cities = City.all
    else
      redirect_to admins_path
    end
  end

  def edit
    @city_cleaner = CitiesCleaner.where(city_id: params[:selectedCity]).pluck(:cleaner_id)
    @cleaners = Cleaner.find(@city_cleaner)
    render layout: false
  end

  def create
    @date = params[:booking].values[0] + "/" + params[:booking].values[1] + "/" + params[:booking].values[2]
    @time = params[:booking].values[3] + ":" + params[:booking].values[4]
    @date_time = (@date + " " + @time).to_datetime
    @city_id = params[:city][:booking]
    @cleaner_id = params[:city][:cleaners]
    @records = Booking.where(datetime: @date_time - 2.hours..@date_time + 2.hours, cleaner_id: @cleaner_id)
    if @records.count == 0
      @booking = Booking.new(cleaner_id: @cleaner_id,city_id: @city_id,customer_id: session[:customer_id],datetime: @date_time)
      if @booking.save
        CleanerMailer.booked().deliver
        redirect_to url_for(:controller => :customers, :action => :index)
      else
        @cities = City.all
        render :new
      end
    else
      flash[:select_another_cleaner] = "Please, select another cleaner"
      @booking = Booking.new
      @cities = City.all
      render :new
    end
  end

  def update
  end

  def destroy
  end

  # Never trust parameters from the scary internet, only allow the white list through.
end
