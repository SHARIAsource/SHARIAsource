class AttachedFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    # TODO: Decide what to allow here
    %w(png jpg gif)
  end
end
