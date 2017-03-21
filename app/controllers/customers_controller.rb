class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
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
    result = false
    if is_customer_exist(params[:customer][:phone_number])
      @customer = Customer.find_by(params[:customer][:phone_number])
      customer_id = @customer.id
      result = true
    else
      @customer = Customer.new(customer_params)
      @customer.save
      customer_id = @customer.id
      result = true
    end
    msg = assign_cleaner(customer_id,params[:customer][:city_id],params[:customer][:date])
    respond_to do |format|
      if result
        format.html { redirect_to @customer, notice: msg }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def is_customer_exist(customers_phone_number)
    Customer.find_by('phone_number = ?',customers_phone_number)
  end

  def assign_cleaner(customer_id,customers_city_id,customers_date)
    byebug
    cleaners = City.find(customers_city_id).cleaner
    byebug
    cleaners.each do |cleaner|
      if Booking.where('cleaner_id = ?',cleaner).where('date = ?',customers_date).count == 0
        Booking.create(cleaner_id: cleaner.id,customer_id: customer_id,date: customers_date)
        byebug
        return "Dear Customer, Your home cleaning duty is assign to #{cleaner.first_name} #{cleaner.last_name}
          on the date #{customers_date}."
      end
    end
    "Dear Customer, Sorry to inform you that becase of heavy booking their
      are no any cleaner available in you city for date #{customers_date}
      you choose. Please try for another date"
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
end
