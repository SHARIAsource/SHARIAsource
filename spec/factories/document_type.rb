FactoryGirl.define do
  factory :document_type do
    sequence(:name) {|n| "Test-Doc-Type-#{n}" }
    sort_order 1
  end
end
