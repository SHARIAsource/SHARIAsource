require 'rails_helper'

feature 'Viewing CorpusBuilder documents' do
  def turn_edit_mode
    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the edit button") do
      while page.evaluate_script('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit").length') == 0
        sleep 2
      end
    end

    page.evaluate_script('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-button-edit")[0].click()')

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the edit lines") do
      while page.evaluate_script('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line-editing").length') == 0
        sleep 2
      end
    end
  end

  def begin_edit_line(number)
    page.evaluate_script("$(\".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line-editing:nth-child(#{number})\").click()")

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the editor box") do
      while page.evaluate_script('$(".corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-shell").length') == 0
        sleep 2
      end
    end
  end

  def set_input_value(selector, txt)
    page.evaluate_script("window.___input_node = $('#{selector}')[0]")
    page.evaluate_script("Object.getOwnPropertyDescriptor(window.___input_node.__proto__, 'value').set.call(window.___input_node, '#{txt}')")
    page.evaluate_script('window.___input_node.dispatchEvent(new Event("input", { bubbles: true }))')
  end

  def edit_word(number, txt)
    set_input_value(
      ".corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-input:nth-child(#{number})",
      txt
    )
  end

  def save_line
    page.evaluate_script("$('.corpusbuilder-viewer:nth-child(1) .corpusbuilder-inline-editor-buttons-aside button:contains(Save)')[0].click()")
  end

  def ensure_line_contains(number, txt)
    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the '#{txt}' in line #{number}") do
      while page.evaluate_script("$(\".corpusbuilder-viewer:nth-child(1) .corpusbuilder-document-line:nth-child(#{number})\").text().match(/#{txt}/)").nil?
        sleep 2
      end
    end
  end

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

  scenario "logging in as master branch owner user sees the Edit button", js: true do
    sign_in_admin

    visit document_path(id: document.id)

    Timeout::timeout(2*60, Timeout::Error, "Couldn't find the CB edit button") do
      while page.evaluate_script('$(".corpusbuilder-button-edit").length') < 1
        sleep 2
      end
    end
  end

  scenario "logging in not as master branch owner user doesn't see the Edit button", js: true do
    sign_in_admin "other-admin@example.com"

    visit document_path(id: document.id)

    Timeout::timeout(2*3, Timeout::Error, "Found the CB edit button when it shouldnt") do
      while page.evaluate_script('$(".corpusbuilder-button-edit").length') >= 1
        sleep 2
      end
    end
  end

  scenario "editing lines works", js: true do
    sign_in_admin

    visit document_path(id: document.id)

    turn_edit_mode

    begin_edit_line 1
    edit_word 1, "test"
    save_line

    ensure_line_contains 1, "test"
  end
end
