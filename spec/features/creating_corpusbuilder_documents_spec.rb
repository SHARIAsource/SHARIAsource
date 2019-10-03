require 'rails_helper'

feature 'Creating CorpusBuilder documents' do
  scenario 'the new document page includes the CB uploader widget', js: true do
    sign_in_admin

    visit new_admin_document_path

    expect_uploader_to_be_on_the_page
  end

  scenario 'not providing the name makes CB show the initial message', js: true do
    sign_in_admin

    visit new_admin_document_path

    expect(page).to have_css '.corpusbuilder-uploader-explain', \
      'You must provide document metadata first. At least the document' + \
      ' title is required to send the scans to be OCR\'ed.'
  end

  scenario 'providing the title makes CB show the upload picker', js: true do
    sign_in_admin

    visit new_admin_document_path

    fill_in "document[title]", with: "Test"
    page.evaluate_script('$("#document_title").trigger("change")')

    expect(page).to have_css '.corpusbuilder-uploader-explain', \
      'If any of the following documents represent the one described' +\
      ' in the metadata: please click on the "Pick" button. Otherwise, please click on next to continue.'

    expect(page).to have_css '.corpusbuilder-uploader-similar-documents-item-top-label', \
      'Add New'
  end
end
