json.array!(@discount_rules) do |discount_rule|
  json.extract! discount_rule, :id, :description, :item_id, :tag_id, :price_discount, :percentage_discount
  json.url discount_rule_url(discount_rule, format: :json)
end
