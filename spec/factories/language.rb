FactoryBot.define do
  factory :language do
    sequence(:name) {|n| "Test-Language-#{n}" }
  end
end
