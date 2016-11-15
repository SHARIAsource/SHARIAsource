namespace :pdf do
  namespace :regenerate do
    desc 'Regenerate JPG images for PDFs with text'
    task with_text: :environment do
      Document.regenerate_all(true)
    end

    desc 'Regenerate JPG images for PDFs without text'
    task sans_text: :environment do
      Document.regenerate_all(false)
    end
  end
end
