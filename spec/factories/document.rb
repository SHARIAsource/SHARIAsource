FactoryGirl.define do
  factory :document do
    association :contributor, factory: :user
    document_type
    title 'Test Document'
  end
end
