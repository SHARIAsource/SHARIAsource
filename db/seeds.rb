path = Rails.root.join('db', 'seeds', "#{Rails.env}.rb")
load path if File.exist?(path)

# `unzip -n db/seeds/example/images/image.zip -d public/uploads/`

# load "db/seeds/example/documents.rb"
# load "db/seeds/example/images.rb"
# load "db/seeds/example/surfaces.rb"
# load "db/seeds/example/zones.rb"
# load "db/seeds/example/graphemes.rb"
