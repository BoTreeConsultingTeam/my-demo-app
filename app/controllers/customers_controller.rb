class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index]


  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @bookings = Booking.where(customer_id: params[:id])
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json

  def create
    @customer = Customer.new(customer_params)
    @cities = City.all
    respond_to do |format|
      if @customer.valid?
        if @customer.save
          @booking = Booking.new(customer_city_id: params["city_id"])
          @booking.cleaning_start = DateTime.new(params[:customer][:booking]["date(1i)"].to_i, params[:customer][:booking]["date(2i)"].to_i, params[:customer][:booking]["date(3i)"].to_i, params[:customer][:booking]["date(4i)"].to_i, params[:customer][:booking]["date(5i)"].to_i)
          @cleaners = City.find(@booking.customer_city_id).cleaners
          @booking.customer_id = @customer.id
          @cleaners.each do |cleaner|
              if cleaner.date.nil? || cleaner.date <= @booking.cleaning_start
                cleaner.update_attribute(:date, @booking.cleaning_start + 2.hours )
                @booking.cleaner_id = cleaner.id
                  if @booking.save
                    format.html { redirect_to @customer, notice: "Account Created, Cleaner name: #{Cleaner.find(@booking.cleaner_id).first_name}" }
                    format.json { render :show, status: :created, location: @customer }
                    ExampleMailer.sample_email(cleaner, @customer).deliver
                    break
                  else
                    format.html { redirect_to @customer, notice: "Account created, Sorry We cant Help you " }
                    format.json { render :show, status: :created, location: @customer }
                    break
                  end
              else
                if @booking.cleaner_id.nil?
                  format.html { redirect_to @customer, notice: "Account Create, Cleaner not found " }
                  format.json { render :show, status: :created, location: @customer }
                else
                  format.html { redirect_to @customer, notice: "Account Create, Cleaner name: #{Cleaner.find(@booking.cleaner_id).first_name} " }
                  format.json { render :show, status: :created, location: @customer }
                end
              end
          end

        else
          format.html { render welcome_index_path }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      else
        @exist = Customer.where(phone_number: @customer.phone_number)
        if @exist.count > 0
          @customer = @exist.first
          @cities = City.all
          @booking = Booking.new(customer_city_id: params["city_id"])
          @booking.cleaning_start = DateTime.new(params[:customer][:booking]["date(1i)"].to_i, params[:customer][:booking]["date(2i)"].to_i, params[:customer][:booking]["date(3i)"].to_i, params[:customer][:booking]["date(4i)"].to_i, params[:customer][:booking]["date(5i)"].to_i)
          @cleaners = City.find(@booking.customer_city_id).cleaners
          @booking.customer_id = @customer.id
          @cleaners.each do |cleaner|
              if cleaner.date.nil? || cleaner.date <= @booking.cleaning_start
                cleaner.update_attribute(:date, @booking.cleaning_start + 2.hours )
                @booking.cleaner_id = cleaner.id
                  if @booking.save
                    format.html { redirect_to @customer, notice: "Account Exist, Cleaner name:#{Cleaner.find(@booking.cleaner_id).first_name}"  }
                    format.json { render :show, status: :created, location: @customer }
                    ExampleMailer.sample_email(cleaner, @customer).deliver
                    break
                  else
                    format.html { redirect_to @customer, notice: "Account Exist, Sorry We cant Help you " }
                    format.json { render :show, status: :created, location: @customer }
                    break
                  end
              else
                if @booking.cleaner_id.nil?
                  format.html { redirect_to @customer, notice: "Account Exist, Cleaner not found " }
                  format.json { render :show, status: :created, location: @customer }
                else
                  format.html { redirect_to @customer, notice: "Account Exist, Cleaner name:#{Cleaner.find(@booking.cleaner_id).first_name} " }
                  format.json { render :show, status: :created, location: @customer }
                end
              end
          end
        else
          format.html { render welcome_index_path }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
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
      params.require(:customer).permit(:first_name, :last_name, :phone_number, :booking)
    end
end
