class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index]

  def index
    @customers = Customer.all
  end

  def show
    @bookings = Booking.where(customer_id: params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    @cities = City.all
    create_customer
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def create_booking
      @booking = Booking.new(customer_city_id: params["city_id"])
      @booking.cleaning_start = DateTime.new(params[:customer][:booking]["date(1i)"].to_i, params[:customer][:booking]["date(2i)"].to_i, params[:customer][:booking]["date(3i)"].to_i, params[:customer][:booking]["date(4i)"].to_i, params[:customer][:booking]["date(5i)"].to_i)
      @booking.customer_id = @customer.id
      @cleaners = City.find(@booking.customer_city_id).cleaners
      @cleaners.each do |cleaner|
        if cleaner.date.nil? || cleaner.date <= @booking.cleaning_start
          cleaner.update_attribute(:date, @booking.cleaning_start + 2.hours )
          @booking.cleaner_id = cleaner.id
          if @booking.save
            cleaner_found
            ExampleMailer.sample_email(cleaner, @customer).deliver
            break
          else
            cleaner_not_found
            break
          end
        end
      end
      if @booking.cleaner_id.nil?
        cleaner_not_found
      end
    end

    def cleaner_found
      redirect_to @customer, notice: "Cleaner name:#{Cleaner.find(@booking.cleaner_id).first_name}"
    end

    def cleaner_not_found
      redirect_to @customer, notice: "Sorry We cant Help you"
    end

    def create_customer
      if @customer.valid?
        if @customer.save
          create_booking
        else
          render welcome_index_path
        end
      else
        if @customer.present?
          @customer = Customer.find_by(phone_number: @customer.phone_number)
          create_booking
        else
          render welcome_index_path
        end
      end
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone_number, :booking)
    end

end
