path = Rails.root.join('db', 'seeds', "#{Rails.env}.rb")
load path if File.exist?(path)
