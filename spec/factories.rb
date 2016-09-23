FactoryGirl.define do

  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation { password }
  end

  factory :team do
    name "Tower"
    user
  end

  factory :project do
    name "tower-index-1"
    team
    user
  end

  factory :todo do
    title "测试 index"
    user
  end

  factory :event do
    action "CREATE_TODO"
    association :creator, factory: :user
    team
  end
end
