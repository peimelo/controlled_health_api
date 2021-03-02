FactoryBot.define do
  factory :unit do
    name { Faker::Name.first_name }

    factory :invalid_unit do
      name { nil }
    end
  end
end
