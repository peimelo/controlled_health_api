FactoryBot.define do
  factory :result do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    description { Faker::Lorem.sentence(word_count: 3) }
    account

    factory :invalid_result do
      date { nil }
    end
  end
end
