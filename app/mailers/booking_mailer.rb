class BookingMailer < ApplicationMailer
  default from: 'lmsbotree@gmail.com'

  def booking_cleaner_email(booking)
    @cleaner = booking
    @url = "https://www.gmail.com"
    mail(to: @cleaner.cleaner.email, subject: 'Congratulation Cleaner')
  end

end
