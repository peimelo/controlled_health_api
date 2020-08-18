FactoryBot.define do
  factory :weight do
    date { '2020-08-16 10:55:53' }
    value { '9.99' }
    user

    factory :invalid_weight do
      date { nil }
    end
  end
end
