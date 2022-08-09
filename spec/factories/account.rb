FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    owner

    factory :invalid_account do
      name { nil }
    end
  end
end
