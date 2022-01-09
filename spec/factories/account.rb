FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    owner
  end
end
