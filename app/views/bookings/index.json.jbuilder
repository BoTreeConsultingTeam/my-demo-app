json.array!(@bookings) do |booking|
  json.extract! booking, :id, :customer_id, :cleaner_id, :date
  json.url booking_url(booking, format: :json)
end
