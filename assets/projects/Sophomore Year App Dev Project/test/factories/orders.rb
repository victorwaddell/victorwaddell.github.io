FactoryBot.define do
  factory :order do
    association :customer
    association :address
    date { Date.current }
    products_total { 0.00 }
    shipping { 0.00 }
    credit_card_number { "4123456789012345" }
    expiration_year { 1.year.from_now.year }
    expiration_month { 12 }
    payment_receipt { nil }
  end
end
