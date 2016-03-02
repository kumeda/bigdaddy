# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog
  cache_storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "uploads/tmp"
  end

  # Create different versions of your uploaded files:
  version :user, :if => :is_user? do
    process :resize_to_fill => [50, 50, 'Center']
    process :convert => 'jpg'
  end
  version :report, :if => :is_report? do
    version :thumb do
      process :resize_to_fill => [350, 250, 'Center']
      process :convert => 'jpg'
    end
    version :normal do
      process :resize_to_limit => [750, 750]
      process :convert => 'jpg'
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png gif)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      name = encode_filename(File.basename(original_filename, ".*")) + '.jpg'
      name.downcase
    end
  end

  private
  def is_report? picture
    model.instance_of?(Report)
  end

  def is_user? picture
    model.instance_of?(User)
  end

  def encode_filename(filename)
    filename.unpack("H*")[0]
  end

end
