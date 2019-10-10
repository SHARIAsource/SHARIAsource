require 'rails_helper'

feature 'Creating CorpusBuilder documents' do
  scenario 'Creating a proper OCR document from multi-paged PDF', js: true do
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

    page.evaluate_script('window._node = $(".corpusbuilder-languages-input input[type=text]")[0]')
    page.evaluate_script('Object.getOwnPropertyDescriptor(window._node.__proto__, "value").set.call(window._node, "Arab")')
    page.evaluate_script('window._node.dispatchEvent(new Event("input", { bubbles: true }))')

    sleep 1

    assert page.evaluate_script('$(".corpusbuilder-languages-input ul li").length') > 0

    page.evaluate_script('$(".corpusbuilder-languages-input ul li")[0].dispatchEvent(new Event("mousedown", { bubbles: true }))')

    sleep 1

    expect(page).to have_css '.corpusbuilder-uploader-model-selection-item-list-item', \
      'Arabic'
  end
end
