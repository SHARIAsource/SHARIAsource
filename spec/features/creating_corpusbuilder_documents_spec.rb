require 'rails_helper'

feature 'Creating CorpusBuilder documents' do
  scenario 'Creating a proper OCR document from multi-paged PDF', js: true do
    create :document_type, name: "Book"
    create :language, name: "Arabic"

    sign_in_admin

    visit new_admin_document_path

    fill_in "document[title]", with: "Test"
    page.evaluate_script('$("#document_title").trigger("change") && 0')

    wait_to "find the similar documents" do
      js!('$(".corpusbuilder-uploader-similar-documents-item:last-child").length') == 0
    end

    js!('$(".corpusbuilder-uploader-similar-documents-item:last-child")[0].click()')
    js!('$(".corpusbuilder-uploader-images-upload-dropzone input").css("display", "inline" ) && 0')

    find('.corpusbuilder-uploader-images-upload-dropzone input', visible: false).send_keys \
      Rails.root.join('spec', 'support', 'files', 'abhath_pdf_test.pdf')

    js!('$(".corpusbuilder-uploader-images-upload-dropzone input").trigger("change") && 0')
    js!('$(".corpusbuilder-uploader-images-upload-buttons button")[1].click()')

    wait_to "find the OCR backend select" do
      js!('$(".corpusbuilder-uploader-images-ready-backend").length') == 0
    end

    set_input_value ".corpusbuilder-languages-input input[type=text]", "Arab"

    wait_to "find the languages to choose from" do
      js!('$(".corpusbuilder-languages-input ul li").length') == 0
    end

    js!('$(".corpusbuilder-languages-input ul li")[0].dispatchEvent(new Event("mousedown", { bubbles: true }))')

    wait_to "find the OCR backend select" do
      js!('$(".corpusbuilder-uploader-model-selection-item-list-item").length') == 0
    end

    expect(page).to have_css '.corpusbuilder-uploader-model-selection-item-list-item', \
      'Arabic'

    find(:css, ".corpusbuilder-uploader-model-selection-item-actions input[type=checkbox]").set(true)
    find('#document_document_type_id').find(:xpath, 'option[2]').select_option
    find('#document_language_id').find(:xpath, 'option[2]').select_option
    find("#new_create_and_edit").click

    expect(page).to have_content("Document created successfully")

    wait_to "find the success message", seconds: 90 do
      js!('$(".corpusbuilder-success").length') == 0
    end

    expect(page).to have_content("Document has been successfully processed")
  end
end
