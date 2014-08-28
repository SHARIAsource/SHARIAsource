# encoding: utf-8

class CollaboratorImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  version :corner_cut do
    process resize_to_fill: [640, 400]
    process convert: 'png'
    process :cut_corners
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(png jpg gif)
  end

  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

  def cut_corners
    manipulate! do |source|
      mask = ::Magick::Image.new(640, 400).matte_floodfill(1, 1)
      ::Magick::Draw.new.polygon(
        12, 0,
        628, 0,
        640, 12,
        640, 388,
        628, 400,
        12, 400,
        0, 388,
        0, 12
      ).fill('white').draw(mask)
      source.composite!(mask, 0, 0, Magick::CopyOpacityCompositeOp)
      source = yield(source) if block_given?
      source
    end
  end
end
