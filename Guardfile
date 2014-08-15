guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/presenters/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) do |m|
    "/assets/#{m[3]}"
  end
end

guard :rspec, cmd: 'spring rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) do |m|
    "spec/lib/#{m[1]}_spec.rb"
  end
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^app/(.+)\.rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) do |m|
    "spec/#{m[1]}#{m[2]}_spec.rb"
  end
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
    [
      "spec/features/#{m[1]}_spec.rb",
      "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
      "spec/acceptance/#{m[1]}_spec.rb"
    ]
  end
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
  watch('config/routes.rb') { 'spec/routing' }
  watch('app/controllers/application_controller.rb') { 'spec/controllers' }
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$}) do |m|
    "spec/features/#{m[1]}_spec.rb"
  end
end

