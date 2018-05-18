namespace :pdf do

  desc 'Safely regenerate JPG images for PDFs with page image files older than :days'
  task :repair_older_than, [:days] => :environment do |t, args|
    Document.repair_pages_days_older_than(args[:days].to_i)
  end

  namespace :regenerate do
    desc 'Regenerate JPG images for PDFs with text, optionally limited to a single doc'
    task :with_text, [:id] => :environment do |t, args|
      Document.regenerate_all(with_text: true, id: args[:id])
    end

    desc 'Regenerate JPG images for PDFs without text, optionally limited to a single doc'
    task :sans_text, [:id] => :environment do |t, args|
      Document.regenerate_all(with_text: false, id: args[:id])
    end
  end
end
