class UserEmail < ApplicationMailer
  default :from => "rms.at.help@gmail.com"

  def confirm_email(cleaner)
    @cleaner = cleaner
    mail(to: @cleaner.email,subject: "Homework Confirmation")
  end

  def send_lead_to_cleaner(cleaner,customer,dateofjob)
    @cleaner = cleaner
    @customer = customer
    @dateofjob = dateofjob
    mail(to: @cleaner.email,subject: "Cleaning Work Assignment")
  end
end
