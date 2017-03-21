class UserEmail < ApplicationMailer
  default :from => "rms.at.help@gmail.com"

  def confirm_email(user)
    @user = user
    mail(to: @user.email,subject: "Confirm you email")
  end

  def send_lead_to_cleaner(cleaner_email)
    mail(to: cleaner_email,subject: "Cleaning Work Assignment")
  end
end
