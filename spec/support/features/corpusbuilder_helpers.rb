module Features
  module CorpusbuilderHelpers
    def expect_uploader_to_be_on_the_page
      expect(page).to have_css '.corpusbuilder-uploader-title', 'Scans of documents to OCR'
    end

    def turn_edit_mode
      wait_to "find the edit button" do
        js!(
          '$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit").length'
        ) == 0
      end

      js!('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit")[0].click()')

      wait_to "find the edit lines" do
        js!(
          '$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line-editing").length'
        ) == 0
      end
    end

    def turn_edit_mode_off
      wait_to "find the edit button" do
        js!(
          '$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit").length'
        ) == 0
      end

      js!('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit")[0].click()')

      wait_to "not find the edit lines" do
        js!(
          '$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line-editing").length'
        ) != 0
      end
    end

    def begin_edit_line(number)
      js!(
        "$(\".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line-editing:nth-child(#{number})\").click()"
      )

      wait_to "find the editor box" do
        js!(
          '$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-shell").length'
        ) == 0
      end
    end

    def set_input_value(selector, txt)
      js!("window.___input_node = $('#{selector}')[0]")
      js!("Object.getOwnPropertyDescriptor(window.___input_node.__proto__, 'value').set.call(window.___input_node, '#{txt}')")
      js!('window.___input_node.dispatchEvent(new Event("input", { bubbles: true }))')
    end

    def edit_word(number, txt)
      set_input_value(
        ".corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-input:nth-child(#{number})",
        txt
      )
    end

    def save_line
      js!("$('.corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-buttons-aside button:contains(Save)')[0].click()")
    end

    def ensure_line_contains(number, txt)
      wait_to "find the '#{txt}' in line #{number}" do
        js!("$(\".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line:nth-child(#{number})\").text().match(/#{txt}/)").nil?
      end
    end

    def ensure_line_doesnt_contain(number, txt)
      wait_to "not find the '#{txt}' in line #{number}" do
        !js!("$(\".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line:nth-child(#{number})\").text().match(/#{txt}/)").nil?
      end
    end

    def commit_changes
      js!("$('.corpusbuilder-button-version')[0].click()")

      wait_to "find the commit button" do
        js!("$('.dd-menu-items button:contains(Commit)').length") == 0
      end

      js!("$('.dd-menu-items button:contains(Commit)')[0].click()")
    end
  end
end

