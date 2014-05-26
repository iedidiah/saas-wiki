  FactoryGirl.define do
    factory :user, aliases: [:creator] do
      sequence(:user_name, 100) { |n| "person#{n}" }
      sequence(:email, 100) { |n| "person#{n}@example.com" }
      paid false
      password "helloworld"
      password_confirmation "helloworld"
      confirmed_at Time.now
    end
  end
