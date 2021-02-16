FactoryBot.define do
  factory :weight do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    value { Faker::Number.within(range: 3..400) }
    user

    factory :invalid_weight do
      date { nil }
    end
  end
end
