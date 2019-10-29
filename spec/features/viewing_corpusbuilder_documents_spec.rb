require 'rails_helper'

feature 'Viewing CorpusBuilder documents' do
  let :document do
    create :document,
      title: "Abhath",
      ocr_document_id: "669e1334-ec0e-4127-b7d5-b9214b758cab",
      published: true
  end

  before(:each) do
    create :document_type, name: "Book"
    create :language, name: "Arabic"
  end

  scenario "seeing the document loaded inside the CorpusBuilder UI", js: true do
    sign_in_admin

    visit document_path(id: document.id)

    sleep 10
    byebug

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the CB UI") do
      while page.evaluate_script('$(".corpusbuilder-document-page").length') < 2
        sleep 2
      end
    end
  end

  scenario "logging in as master branch owner user sees the Edit button"

  scenario "logging in not as master branch owner user doesn't see the Edit button"
end
