require 'rails_helper'

feature 'Viewing CorpusBuilder documents' do
  let :document do
    create :document,
      title: "Abhath",
      ocr_document_id: "89fabadc-2593-4f02-b272-53287b05a920",
      published: true
  end

  before(:each) do
    create :document_type, name: "Book"
    create :language, name: "Arabic"
  end

  scenario "seeing the document loaded inside the CorpusBuilder UI", js: true do
    sign_in_admin

    visit document_path(id: document.id)

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the CB UI") do
      while page.evaluate_script('$(".corpusbuilder-document-page").length') < 2
        sleep 2
      end
    end
  end

  scenario "logging in as master branch owner user sees the Edit button"

  scenario "logging in not as master branch owner user doesn't see the Edit button"
end
