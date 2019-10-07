module Features
  module CorpusbuilderHelpers
    def expect_uploader_to_be_on_the_page
      expect(page).to have_css '.corpusbuilder-uploader-title', 'Scans of documents to OCR'
    end
  end
end

