class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index]
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
    if phone_exist(params[:customer][:phone_number])
      @customer = Customer.find_by(phone_number: params[:customer][:phone_number])
      customer_id = @customer.id
      flag = true
    else
      @customer = Customer.new(customer_params)
      flag = @customer.save
      customer_id = @customer.id
    end
    respond_to do |format|
      if flag == true
        display = assign_cleaner(customer_id,params[:customer][:city_id],params[:customer][:date])
        format.html { redirect_to @customer, notice: display }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
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
  def phone_exist(number)
    Customer.find_by('phone_number = ?',number)
  end

  def assign_cleaner(customer_id, customers_city_id, customers_date)
    cleaners = City.find(customers_city_id).cleaners
    cleaners.each do |cleaner|
      if Booking.where('cleaner_id = ?',cleaner.id).where('date = ?',customers_date).count == 0

        Booking.create(cleaner_id: cleaner.id,customer_id: customer_id,date: customers_date)
        return "Assigned to #{cleaner.first_name} #{cleaner.last_name}
          on  #{customers_date}."
      end
    end
    return "sorry No cleaner available"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end
    def add_bookings

    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone_number, :date, :city_id)
    end

end
