FactoryBot.define do
  factory :item do
    name { Faker::Games::Dota.item }
    description { Faker::Hipster.sentence(word_count: 3) }
    unit_price { Faker::Commerce.price }
    merchant { Faker::Company.name }
    association :merchant, factory: :merchant
  end
end
