require 'rails_helper'

feature 'Creating CorpusBuilder documents' do
  scenario 'the new document page includes the CB uploader widget', js: true do
    sign_in_admin

    visit new_admin_document_path

    page.save_screenshot('/shariasource/tmp/page.png')
    byebug
    expect_uploader_to_be_on_the_page
  end
end
