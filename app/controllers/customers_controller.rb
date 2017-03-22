class CustomersController < ApplicationController
  before_action :authenticate_admin!, :except => [:new, :create, :show]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @bookings = @customer.bookings.includes(:cleaner)
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @cities = City.all
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    result = set_customer_detail(params[:customer])
    respond_to do |format|
      if result
        event = params[:customer]
        date = Date.new event["date(1i)"].to_i, event["date(2i)"].to_i, event["date(3i)"].to_i
        booking_done = booking_cleaner(date,params[:city])
        puts booking_cleaner(date,params[:city])
        if booking_done 
          format.html { redirect_to booking_path(@booking.id), notice: 'Congratulations Booking is successfully created !' }
        else
          format.html { redirect_to @customer, notice: 'Sorry, There is no cleaner available' }
        end
      else
        format.html { render 'new' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
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

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone_number)
    end

    def set_customer_detail(customer_params)
      result = Customer.where(phone_number: customer_params[:phone_number]).any?
      if result
        @customer = Customer.find_by_phone_number(customer_params[:phone_number])
      else
        customer_set = true if @customer.save 
      end 
      return true if result || customer_set
    end

    def booking_cleaner(date,city)
      city = City.find(city)
      cleaners = city.cleaners
      return false if cleaners.count == 0
      cleaners.each do |cleaner|
        booking = cleaner.bookings.where(date: date).any?
        unless booking
          @booking = Booking.create(customer: @customer,cleaner: cleaner,date: date)
          if @booking.save
            ExampleMailer.sample_email(cleaner,@booking,@customer).deliver_now
            return true
          end
        else
          return false
        end
      end
    end

end
