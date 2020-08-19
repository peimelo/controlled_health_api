FactoryBot.define do
  factory :height do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    value { Faker::Number.decimal(l_digits: 1) }
    user

    factory :invalid_height do
      date { nil }
    end
  end
end
