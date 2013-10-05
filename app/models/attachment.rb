class Attachment
  include Mongoid::Document

  mount_uploader :asset, AttachmentUploader

  field :description
  field :name
  field :content_type
  field :file_size

  before_save :update_file_metadata

  belongs_to :page

  private
  def update_file_metadata
    if asset.present?
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
  end

end
