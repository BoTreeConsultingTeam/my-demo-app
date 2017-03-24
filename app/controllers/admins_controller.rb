class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @bookings = Booking.includes(:cleaner, :customer, :city).all
  end

  def show; end

  def delete; end

  def new; end

  def create; end

  def edit; end

  def update; end
end
