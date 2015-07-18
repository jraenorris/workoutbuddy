require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:fullname) { |n| "Full Name of #{n}" }
    password 'password'
    password_confirmation 'password'
  end

  FactoryGirl.define do
    factory :workout do
      sequence(:name) { |n| "Workout ##{n}" }
      description 'Created today this new great workout'
      user
    end
  end

  FactoryGirl.define do
    factory :exercise do
      workout
      activity "push ups"
      intensity "10x"
    end
  end
end
