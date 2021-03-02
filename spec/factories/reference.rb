FactoryBot.define do
  factory :reference do
    name { Faker::Name.first_name }

    factory :invalid_reference do
      name { nil }
    end
  end
end
