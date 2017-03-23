class CleanerMailer < ApplicationMailer
  default from: 'lmsbotree@gmail.com'

  def booked
    @booking = Booking.includes(:city, :cleaner, :customer).last
    @city = @booking.city
    @customer = @booking.customer
    @cleaner = @booking.cleaner
    mail(to: @cleaner.email, subject: 'Got booking for cleaning')
  end
end
