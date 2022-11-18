json.shops @shops do |shop|
  json.extract! shop, :id, :name
  json.url url_for(shop)
end
