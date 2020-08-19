FactoryBot.define do
  factory :weight do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    value { Faker::Number.decimal(l_digits: 2) }
    user

    factory :invalid_weight do
      date { nil }
    end
  end
end
