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

  scenario 'Clicking on add new making the uploader show the drop area', js: true do
    sign_in_admin

    visit new_admin_document_path

    fill_in "document[title]", with: "Test"
    page.evaluate_script('$("#document_title").trigger("change")')

    sleep 0.1

    page.evaluate_script('$(".corpusbuilder-uploader-similar-documents-item:last-child")[0].click()')

    expect(page).to have_css '.corpusbuilder-uploader-images-upload-dropzone', \
      'Drop Files Here'
  end

  scenario 'Attaching a file in the uploader shows it as an item on the list', js: true do
    sign_in_admin

    visit new_admin_document_path

    fill_in "document[title]", with: "Test"
    page.evaluate_script('$("#document_title").trigger("change")')

    sleep 0.1

    page.evaluate_script('$(".corpusbuilder-uploader-similar-documents-item:last-child")[0].click()')
    page.evaluate_script('$(".corpusbuilder-uploader-images-upload-dropzone input").css("display", "inline")')

    find('.corpusbuilder-uploader-images-upload-dropzone input', visible: false).send_keys \
      Rails.root.join('spec', 'support', 'files', 'abhath_pdf_test.pdf')

    page.evaluate_script('$(".corpusbuilder-uploader-images-upload-dropzone input").trigger("change")')

    sleep 0.1

    expect(page).to have_css '.corpusbuilder-uploader-images-upload-files-item-name', \
      'abhath_pdf_test.pdf'
  end

  scenario 'Attaching a file in the uploader shows it as an item on the list', js: true do
    sign_in_admin

    visit new_admin_document_path

    fill_in "document[title]", with: "Test"
    page.evaluate_script('$("#document_title").trigger("change")')

    sleep 0.1

    page.evaluate_script('$(".corpusbuilder-uploader-similar-documents-item:last-child")[0].click()')
    page.evaluate_script('$(".corpusbuilder-uploader-images-upload-dropzone input").css("display", "inline")')

    find('.corpusbuilder-uploader-images-upload-dropzone input', visible: false).send_keys \
      Rails.root.join('spec', 'support', 'files', 'abhath_pdf_test.pdf')

    page.evaluate_script('$(".corpusbuilder-uploader-images-upload-dropzone input").trigger("change")')

    sleep 0.1

    page.evaluate_script('$(".corpusbuilder-uploader-images-upload-buttons button")[1].click()')

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the OCR backend select") do
      while page.evaluate_script('$(".corpusbuilder-uploader-images-ready-backend").length') == 0
        sleep 1
      end
    end
  end
end
