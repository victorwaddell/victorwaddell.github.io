FactoryBot.define do
  factory :item do
    name { "GPBO Baking Sheet" }
    description { "Our best aluminum baking sheet pan, it is both rust proof and warp resistant and measures 15.1 x 10.6 inches" }
    association :category
    color { "Silver"}
    inventory_level { 100 }
    reorder_level { 50 }
    weight { 1.3 }
    is_featured { false }
    active { true }
  end
end
