FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }

    factory :confirmed_user do
      confirmed_at { Time.now }
    end
  end
end
