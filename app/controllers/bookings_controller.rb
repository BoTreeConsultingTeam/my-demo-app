class BookingsController < ApplicationController
  before_action :get_cities, only: [:new, :create]

  def index
    redirect_to customers_path
  end

  def show; end

  def new
    if current_admin.nil?
      @booking = Booking.new
    else
      redirect_to admins_path
    end
  end

  def edit
    @city_cleaner_id = CitiesCleaner.where(city_id: params[:selectedCity]).pluck(:cleaner_id)
    @cleaners = Cleaner.find(@city_cleaner_id)
    render layout: false
  end

  def create
    @date = "#{params[:booking].values[0]}/#{params[:booking].values[1]}/#{params[:booking].values[2]}"
    @time = "#{params[:booking].values[3]}:#{params[:booking].values[4]}"
    @date_time = (@date + " " + @time).to_datetime
    @city_id = params[:city][:booking]
    @cleaner_id = params[:city][:cleaners]
    @hours = (Settings.default.set_duration_for_cleaning.hours).hours
    @records = Booking.where(datetime: @date_time - @hours..@date_time + @hours, cleaner_id: @cleaner_id)
    if !@records.present?
      @booking = Booking.new(cleaner_id: @cleaner_id, city_id: @city_id, customer_id: session[:customer_id], datetime: @date_time)
      if @booking.save
        CleanerMailer.booked.deliver_later
        redirect_to url_for(:controller => :customers, :action => :index)
      else
        render :new
      end
    else
      flash[:select_another_cleaner] = 'Please, select another cleaner'
      @booking = Booking.new
      render :new
    end
  end

  def update; end

  def destroy; end

  private

  def get_cities
    @cities = City.all
  end
end
