FactoryBot.define do
  factory :invoice do
    status { 0 }
    association :merchant
    association :customer
  end
end
