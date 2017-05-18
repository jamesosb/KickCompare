json.array!(@offers) do |offer|
  json.extract! offer, :id, :name, :desc, :kicks_id, :retailers_id, :price, :price
  json.url offer_url(offer, format: :json)
end
