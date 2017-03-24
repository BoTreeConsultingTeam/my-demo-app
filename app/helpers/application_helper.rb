module ApplicationHelper

  def customer_name customer
     "#{customer.first_name}  #{customer.last_name}"
  end

  def cleaner_name cleaner
     "#{cleaner.first_name}  #{cleaner.last_name}"
  end

  def booking_date datetime
    datetime.localtime.strftime("%m/%d/%Y %H:%M")
  end
end
