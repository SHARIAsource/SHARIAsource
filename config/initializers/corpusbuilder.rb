Corpusbuilder::Ruby::Api.config.api_url = ENV['CORPUS_BUILDER_API_URL']
Corpusbuilder::Ruby::Api.config.public_url = ENV['CORPUS_BUILDER_PUBLIC_URL']
Corpusbuilder::Ruby::Api.config.api_version = ENV['CORPUS_BUILDER_API_VERSION']
Corpusbuilder::Ruby::Api.config.app_id = ENV['CORPUS_BUILDER_SHARIA_SOURCE_APP_ID']
Corpusbuilder::Ruby::Api.config.token = ENV['CORPUS_BUILDER_SHARIA_SOURCE_TOKEN']
Corpusbuilder::Ruby::Api.config.editor_id = -> (controller) {
  controller.current_user.try(:editor_id)
}
