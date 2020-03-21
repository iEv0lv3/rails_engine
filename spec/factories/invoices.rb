FactoryBot.define do
  factory :invoice do
    status { 0 }
    customer { Faker::Name.name_with_middle }
    merchant { Faker::Company.name }
    association :merchant, factory: :merchant
    association :customer, factory: :customer
  end
end
