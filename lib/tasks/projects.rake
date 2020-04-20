namespace :projects do
  desc "Generates slugs for existing projects"
  task :generate_slugs => :environment do
    Project.find_each(&:save)
  end
end
