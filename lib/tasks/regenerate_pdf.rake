namespace :pdf do
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
