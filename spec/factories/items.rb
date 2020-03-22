FactoryBot.define do
  factory :item do
    name { Faker::Games::Dota.item }
    description { Faker::Hipster.sentence(word_count: 3) }
    unit_price { Faker::Commerce.price }
    association :merchant
  end
end
