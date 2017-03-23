class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    if current_admin.nil?
      @bookings = Booking.includes(:city, :customer, :cleaner).where(customer_id: session[:customer_id])
    else
      @customers = Customer.all
    end
  end

  def show
  end

  def new
    if current_admin.nil?
      @customer = Customer.new
    else
      redirect_to admins_path
    end
  end

  def edit
  end

  def create
    if params[:commit] == "Log in"
      @login_customer = Customer.where(phone_number: params[:customer][:phone_number], password: params[:customer][:password])
      if @login_customer.count == 1
        session[:customer_id] = @login_customer.first.id
        redirect_to action: "index"
      else
        flash[:invalid_customer] = "Invalid Phone Number or Password"
        redirect_to action: "new"
      end
    elsif params[:commit] == "Sign up"
      @customer = Customer.new(customer_params)
      if @customer.save
        session[:customer_id] = @customer.id
        redirect_to action: "index"
      else
        render :new
      end
    end
  end


  def update
  end

  def destroy
    #destroy session of customer
    session[:customer_id] = nil
    redirect_to new_customer_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
      @customer_booking = Booking.where(customer_id: params[:id]).includes(:cleaner,:city)
    end
    def customer_params
      params.require(:customer).permit(:first_name,:last_name,:phone_number,:password)
    end
end
