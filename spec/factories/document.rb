FactoryGirl.define do
  factory :document do
    association :contributor, factory: :user
    document_type
    language
    title 'Test Document'
  end
end
