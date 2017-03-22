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
    respond_to do |format|
      if add_customer
        message = assign_cleaner(@customer.id,params[:customer][:city_id],params[:customer][:date])
        format.html { redirect_to @customer, notice: message }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_customer
    if is_customer_exist(params[:customer][:phone_number])
      @customer = Customer.find_by(phone_number: params[:customer][:phone_number])
    else
      @customer = Customer.new(customer_params)
      @customer.save
    end
  end

  def is_customer_exist(customers_phone_number)
    Customer.find_by('phone_number = ?',customers_phone_number)
  end

  def assign_cleaner(customer_id,customers_city_id,customers_date)
    cleaners = City.find(customers_city_id).cleaner
    cleaners.each do |cleaner|
      if cleaner_available_for_date(cleaner,customers_date)

        Booking.create(cleaner_id: cleaner.id,customer_id: customer_id,date: customers_date)

        # Send email to cleaner for new work assignment
        send_email(cleaner.email)

        return "Dear Customer, Your home cleaning duty is assign to #{cleaner.first_name} #{cleaner.last_name}
          on the date #{customers_date}."
      end
    end
    "Dear Customer, Sorry to inform you that because of heavy booking their
      are no any cleaner available in you city for date #{customers_date}
      you choose. Please try for another date."
  end

  def cleaner_available_for_date(cleaner,customers_date)
    Booking.where('cleaner_id = ?',cleaner).where('date = ?',customers_date).count == 0 ? true : false
  end

  def send_email(email)
    UserEmail.send_lead_to_cleaner(email).deliver
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
      params.require(:customer).permit(:first_name, :last_name, :phone_number, :city_id, :date)
    end
end
