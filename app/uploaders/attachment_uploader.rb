# encoding: utf-8
require 'carrierwave/processing/mime_types'

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::MiniMagick

  process :set_content_type

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_and_pad => [150,150]
  end

  version :thumb_retina do
    process :resize_and_pad => [300,300]
  end

  version :square do
    process :resize_and_pad  => [250, 250]
  end

  version :square_retina do
    process :resize_and_pad  => [250, 250]
  end

  version :small do
    process :resize_to  => [320,320]
  end

  version :small_retina do
    process :resize_to  => [640,640, 80]
  end

  version :medium do
    process :resize_to  => [800,800]
  end

  version :medium_retina do
    process :resize_to  => [1600,1600]
  end

  version :large do
    process :resize_to  => [1024,1024]
  end

  version :large_retina do
    process :resize_to  => [2048,2048, 80]
  end

  def full_filename(for_file)
    super.tap do |file_name|
      file_name.sub!(/(.*)\./, '\1@2x.').gsub!('retina_', '') if version_name.to_s.include?('retina')
    end
  end

  def resize_to(width, height, quality = nil)
    manipulate! do |img|
      img.resize "#{width}x#{height}>"
      img.auto_orient
      img.quality quality.to_s if quality
      img = yield(img) if block_given?
      img
    end
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
