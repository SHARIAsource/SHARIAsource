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

      ensure_edit_mode
    end

    def ensure_edit_mode
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

    def new_branch(name)
      choose_version_menu_item "New Branch"

      wait_to "find the new branch window" do
        js!("$('.corpusbuilder-new-branch-window').length") == 0
      end

      set_input_value(
        ".corpusbuilder-new-branch-window input",
        name
      )

      js!("$('.corpusbuilder-new-branch-window button:contains(#{title})').click()")
    end

    def choose_version_menu_item(title)
      wait_to "find the version menu" do
        js!("$('.corpusbuilder-button-version').length") == 0
      end

      js!("$('.corpusbuilder-button-version').click()")

      wait_to "find the #{title.downcase} button" do
        js!("$('.dd-menu-items button:contains(#{title})').length") == 0
      end

      js!("$('.dd-menu-items button:contains(#{title})').click()")
    end

    def commit_changes
      choose_version_menu_item "Commit"
    end

    def reset_changes
      choose_version_menu_item "Reset Changes"
    end
  end
end

