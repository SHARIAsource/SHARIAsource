# encoding: utf-8

class EditorImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  version :thumb do
    process resize_to_fit: [200, 10000]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(png jpg gif)
  end
end

