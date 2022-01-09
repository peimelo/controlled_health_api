FactoryBot.define do
  factory :height do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    value { Faker::Number.within(range: 20..250) }
    account

    factory :invalid_height do
      date { nil }
    end
  end
end
