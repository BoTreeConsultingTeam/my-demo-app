module CleanersHelper
  def verification_state_btn(email_confirmed)
    email_confirmed ? "primary" : "danger"
  end

  def verification_state_msg(email_confirmed)
    email_confirmed ? "Verified" : "Unverified"
  end
end
