FactoryBot.define do
  factory :transaction do
    credit_card_number { 1 }
    credit_card_expiration_date { "" }
    result { "success" }
    association :invoice
  end
end
