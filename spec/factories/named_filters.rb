FactoryBot.define do
  factory :named_filter do
    name "MyString"
    q "MyString"
    date_from "2017-09-29"
    date_to "2017-09-29"
    date_format "MyString"
    language nil
    user nil
    topic nil
    theme nil
    region nil
    era nil
    document_type nil
    sort "MyString"
    page 1
  end
end
