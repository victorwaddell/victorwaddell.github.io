FactoryBot.define do
  factory :address do
    association :customer
    recipient { "Ted Gruberman" }
    street_1 { "5000 Forbes Avenue" }
    street_2 { nil }
    city { "Pittsburgh" }
    state { "PA" }
    zip { "15213" }
    active { true }
    is_billing { false }
  end
end
