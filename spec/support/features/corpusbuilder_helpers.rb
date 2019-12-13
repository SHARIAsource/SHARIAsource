module Features
  module CorpusbuilderHelpers
    def expect_uploader_to_be_on_the_page
      expect(page).to have_css '.corpusbuilder-uploader-title', 'Scans of documents to OCR'
    end

    def turn_diff_mode(which: :left)
      pane = which == :right ? 1 : 0

      choose_menu_item "Changes And Merging", menu: "view", which: which

      wait_to "find the diff view options" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-diff-options').length"
        ) < 1
      end
    end

    def merge_branch(which: :left)
      pane = which == :right ? 1 : 0

      wait_to "find the merge button" do
        js!(
          "$('.corpusbuilder-diff-options button:contains(Merge)').length"
        ) < 1
      end

      js! "$('.corpusbuilder-diff-options button:contains(Merge)').click()"

      wait_to "find the merge confirmation window" do
        js! "$('.corpusbuilder-diff-options button:contains(Merge)').click()"

        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-merge-branches-window').length"
        ) < 1
      end

      js! "$('.corpusbuilder-merge-branches-window button:contains(Merge Now)').click()"
    end

    def choose_diff_branch(branch)
      js! "$('.corpusbuilder-diff-options-branches button').click()"
      js! "$('.corpusbuilder-diff-options-branches button:contains(#{branch})').click()"
    end

    def turn_edit_mode(which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the edit button" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-button-edit').length"
        ) == 0
      end

      js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-button-edit').click()")

      ensure_edit_mode which: which
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      retry
    end

    def ensure_edit_mode(which: :right)
      pane = which == :right ? 1 : 0
      ran = false

      wait_to "find the edit lines" do
        js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-button-edit').click()") if ran

        result = js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line-editing').length"
        ) == 0

        ran = true

        result
      end

    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      retry
    end

    def turn_edit_mode_off(which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the edit button" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-button-edit').length"
        ) == 0
      end

      js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-button-edit').click()")

      wait_to "not find the edit lines" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line-editing').length"
        ) != 0
      end
    rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
    end

    def begin_edit_line(number, which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the editor line" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line-editing:nth-child(#{number})').length"
        ) == 0
      end

      js!(
        "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line-editing:nth-child(#{number})').click()"
      )

      wait_to "find the editor box" do
        js!(
          "$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-inline-editor-shell').length"
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
        ".corpusbuilder-inline-editor-input:nth-child(#{number})",
        txt
      )
    end

    def save_line(which: :right)
      pane = which == :right ? 1 : 0

      js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-inline-editor-buttons-aside button:contains(Save)')[0].click()")
    end

    def ensure_line_contains(number, txt, which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the '#{txt}' in line #{number}" do
        js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line:nth-child(#{number})').text().match(/#{txt}/)").nil?
      end
    end

    def ensure_line_doesnt_contain(number, txt, which: :right)
      pane = which == :right ? 1 : 0

      wait_to "not find the '#{txt}' in line #{number}" do
        !js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.corpusbuilder-document-line:nth-child(#{number})').text().match(/#{txt}/)").nil?
      end
    end

    def new_branch(name, which: :right)
      choose_menu_item "New Branch", which: which

      wait_to "find the new branch window" do
        js!("$('.corpusbuilder-new-branch-window').length") == 0
      end

      set_input_value(
        ".corpusbuilder-new-branch-window input",
        name
      )

      js!("$('.corpusbuilder-new-branch-window button').click()")
    end

    def click_menu(menu, which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the #{menu} menu" do
        js!("$($('.corpusbuilder-button-#{menu}')[#{pane}]).length") < 1
      end

      wait_to "find menu items" do
        js!("$($('.corpusbuilder-button-#{menu}')[#{pane}]).click()")
        js!("$($('.corpusbuilder-button-#{menu}')[#{pane}]).parent().find('li').length") < 1
      end
    end

    def click_view_menu(which: :right)
      click_menu "view", which: which
    end

    def click_version_menu(which: :right)
      click_menu "version", which: which
    end

    def mouseover_menu(title, which: :right)
      wait_to "find the '#{title.downcase}' button" do
        js!("$('.dd-menu-items button:contains(#{title})').length") == 0
      end

      js! <<-JS
        $('.dd-menu-items button:contains(#{title}:)').parent()[0].dispatchEvent(
          new MouseEvent(
            'mouseover',
            {
              'view': window,
              'bubbles': true,
              'cancelable': true
            }
          )
        )
      JS
    end

    def click_branch_button(branch, which: :right)
      js! <<-JS
        $('button:contains(Branch: #{branch})').
          parent().
          find('ul li button:contains(#{branch})').
          click()
      JS
    end

    def choose_menu_item(title, menu: "version", which: :right)
      pane = which == :right ? 1 : 0

      wait_to "find the #{title.downcase} button" do
        click_menu menu, which: which

        js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.dd-menu-items button:contains(#{title})').length") == 0
      end

      js!("$($('.corpusbuilder-viewer')[#{pane}]).find('.dd-menu-items button:contains(#{title})').click()")
    end

    def commit_changes(which: :right)
      choose_menu_item "Commit", which: which
    end

    def reset_changes(which: :right)
      choose_menu_item "Reset Changes", which: which
    end

    def switch_branch(branch, which: :right)
      click_version_menu which: which
      mouseover_menu "Branch", which: which
      click_branch_button branch, which: which
    end
  end
end

