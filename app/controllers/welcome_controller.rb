class WelcomeController < ApplicationController

  def index
    @customer = Customer.new
    @booking = Booking.new
    @cities = City.all
  end
  
end
