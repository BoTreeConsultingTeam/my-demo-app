json.array!(@cleaners) do |cleaner|
  json.extract! cleaner, :id, :first_name, :last_name, :quality_score
  json.url cleaner_url(cleaner, format: :json)
end
