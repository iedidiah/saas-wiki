  FactoryGirl.define do
    factory :user do
      sequence(:user_name, 100) { |n| "person#{n}" }
      sequence(:email, 100) { |n| "person#{n}@example.com" }
      password "helloworld"
      password_confirmation "helloworld"
      confirmed_at Time.now
    end
  end
