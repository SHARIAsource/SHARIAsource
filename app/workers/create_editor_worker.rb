class CreateEditorWorker
  include Sidekiq::Worker

  def perform(editor_id)
    editor = User.find editor_id
    api = Corpusbuilder::Ruby::Api.new
    api.create_editor({email: editor.email, first_name: editor.first_name, last_name: editor.last_name})
  end
end
