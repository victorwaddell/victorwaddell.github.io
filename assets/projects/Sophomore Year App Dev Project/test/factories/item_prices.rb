FactoryBot.define do
  factory :item_price do
    association :item
    price { 1.00 }
    # is_retail { true }
    start_date { Date.current }
    end_date { nil }
  end
end
