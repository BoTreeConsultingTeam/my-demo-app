class ExampleMailer < ApplicationMailer
  default from: "homecleaninghelp@gmail.com"
  def sample_email(cleaner,booking,customer)
	@cleaner = cleaner
	@booking = booking
	@customer = customer
	mail(to: @cleaner.email, subject: 'Booking For Home Cleaning')
  end
end
