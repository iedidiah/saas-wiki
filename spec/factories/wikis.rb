# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    title "First Wiki"
    body "This is the first post that Admin is writing."
    public true
    user_id nil
  end
end
