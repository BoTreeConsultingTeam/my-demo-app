class CleanerMailer < ApplicationMailer
  default from: 'rms.at.help@gmail.com'
  layout 'mailer'

  def cleaner_email(cleaner , customer)
    @cleaner = cleaner
    @customer = customer
    mail(to: @cleaner.email, subject: 'Cleaner Work')
  end
end
