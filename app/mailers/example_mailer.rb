class ExampleMailer < ApplicationMailer
default from: "rms.at.help@gmail.com"
layout "mailer"
def sample_email(cleaner, customer)
    @cleaner = cleaner
    @customer = customer
    mail(to: @cleaner.email, subject: 'Sample Email')
  end
end
