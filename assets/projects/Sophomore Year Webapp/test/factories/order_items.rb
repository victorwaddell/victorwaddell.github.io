FactoryBot.define do
  factory :order_item do
    association :order
    association :item
    quantity { 1 }
    shipped_on { nil }
  end
end
