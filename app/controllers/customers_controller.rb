class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index,:destroy, :update]


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
    @cities=City.all
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @city=City.find(params[:customer][:city])
    @cleaners=@city.cleaners
    @current_customer= Customer.find_by(phone_number: @customer.phone_number)
    if @current_customer.nil?
      respond_to do |format|
        if @customer.save
          @cleaners.each do |cleaner|
            if Booking.where(date:params[:customer][:booking][:date],cleaner_id: cleaner.id).count == 0
              @booking=Booking.create(cleaner_id:cleaner.id, customer_id: @customer.id , date: params[:customer][:booking][:date])
              customer=@customer
              CleanerMailer.cleaner_email(cleaner , customer).deliver
              break
            end
          end
          format.html { redirect_to booking_path(@booking), notice: 'Customer was successfully created.' }
          format.json { render :show, status: :created, location: @customer }
        else
          format.html { render :new }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    else
      @cleaners.each do |cleaner|
        if Booking.where(date:params[:customer][:booking][:date],cleaner_id: cleaner.id).count == 0
          @booking=Booking.create(cleaner_id:cleaner.id, customer_id: @current_customer.id , date: params[:customer][:booking][:date])
          customer = @current_customer
          CleanerMailer.cleaner_email(cleaner , customer).deliver

          break
        end
      end
      if @booking.nil?
        flash[:notice] = "Sorry cleaners not available or invalide date please try again!!"
        redirect_to new_customer_path

      else
        redirect_to booking_path(@booking)
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
      params.require(:customer).permit(:first_name, :last_name, :phone_number , :city)
    end
end
