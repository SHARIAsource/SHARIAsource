FactoryBot.define do
  factory :document do
    contributors { [FactoryBot.create(:user)] }
    document_type
    language
    title 'Test Document'
  end
end
