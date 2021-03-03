FactoryBot.define do
  factory :exam do
    name { Faker::Name }

    factory :invalid_exam do
      name { nil }
    end
  end
end
