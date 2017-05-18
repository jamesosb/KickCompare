json.array!(@kicks) do |kick|
  json.extract! kick, :id, :name, :product_type, :manufacturer
  json.url kick_url(kick, format: :json)
end
