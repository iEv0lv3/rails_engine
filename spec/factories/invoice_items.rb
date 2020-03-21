FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..100) }
    unit_price { Faker::Commerce.price }
    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end
