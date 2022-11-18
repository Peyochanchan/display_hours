json.extract! @shop, :id, :name
json.url url_for(@shop)
json.partial! partial: "api/v1/shops/shop", opening_days: @shop.opening_days
