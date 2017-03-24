module ApplicationHelper
  def full_name(record_for_name)
    "#{record_for_name.first_name} #{record_for_name.last_name}"
  end
end
