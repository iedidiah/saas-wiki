  FactoryGirl.define do
    factory :user do
      user_name "Admin"
      email "admin@example.com"
      password "helloworld"
      password_confirmation "helloworld"
      confirmed_at Time.now
    end
  end
