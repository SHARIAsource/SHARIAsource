# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(png jpg gif)
  end

  def default_url(*args)
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "shariasource_default.jpg"].compact.join('_'))
    ActionController::Base.helpers.asset_path("" + [version_name, "shariasource_default.jpg"].compact.join('_'))
  end

end
