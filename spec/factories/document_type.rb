FactoryGirl.define do
  factory :document_type do
    sequence(:name) {|n| "Test-Doc-Type-#{n}" }
  end
end
