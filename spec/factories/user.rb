FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user-#{n}@example.org" }
    password 'testpassword'
    password_confirmation 'testpassword'
    first_name 'John'
    last_name 'Al Doe'
  end
end
