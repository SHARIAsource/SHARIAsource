FactoryGirl.define do
  factory :source do
    association :contributor, factory: :user
    document_type
    title 'Test Source'
  end
end
