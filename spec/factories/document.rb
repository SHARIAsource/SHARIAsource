FactoryGirl.define do
  factory :document do
    contributors { [FactoryGirl.create(:user)] }
    document_type
    language
    title 'Test Document'
  end
end
