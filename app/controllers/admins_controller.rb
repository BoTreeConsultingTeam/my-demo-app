class AdminsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @bookings = Booking.all
  end

  def new
  end

  def show
  end

  def edit
  end
end
