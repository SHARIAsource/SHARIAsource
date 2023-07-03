# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( vendor/modernizr.js admin.js admin.css mce_custom.css)

# Error: ActionView::Template::Error (undefined method `start_with?' for /\.(?:svg|eot|woff|woff2|ttf)\z/:Regexp):
# See: https://github.com/rails/sprockets/issues/632
# If this doesn't help, try locking to sprockets 3.7.2
# Rails.application.config.assets.precompile << ["*.svg", "*.eot", "*.woff", "*.ttf"]