FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    uid { email }
    password { 'P4$$word' }
    password_confirmation { password }

    factory :confirmed_user do
      confirmed_at { Time.now }
    end

    factory :user_without_uid do
      uid { '' }
    end
  end
end
