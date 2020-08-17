FactoryBot.define do
  factory :height do
    date { 2.years.ago }
    value { 1.8 }
    user

    factory :invalid_height do
      date { nil }
    end
  end
end
