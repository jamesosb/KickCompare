json.array!(@retailers) do |retailer|
  json.extract! retailer, :id, :name, :desc, :kicks_id
  json.url retailer_url(retailer, format: :json)
end
