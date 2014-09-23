# encoding: utf-8

class PageImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  process :store_dimensions

  version :thumb do
    process resize_to_fit: [280, 160]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(png jpg gif)
  end

  def store_dimensions
    if file && model
      img = ::Magick::Image::read(file.file).first
      model.width = img.columns
      model.height = img.rows
    end
  end
end
