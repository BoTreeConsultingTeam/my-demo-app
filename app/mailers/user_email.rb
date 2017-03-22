class UserEmail < ApplicationMailer
  default :from => "rms.at.help@gmail.com"

  def confirm_email(cleaner)
    @cleaner = cleaner
    mail(to: @cleaner.email,subject: "Homework Confirmation")
  end

  def send_lead_to_cleaner(cleaner)
    @cleaner = cleaner
    mail(to: @cleaner.email,subject: "Cleaning Work Assignment")
  end
end
