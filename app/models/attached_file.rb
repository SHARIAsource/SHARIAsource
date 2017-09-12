class AttachedFile < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: true, autosave: true

  validates :user, presence: true
  validates :file, presence: true
  validate :token_or_attachable
  before_save :clear_token, :if => :attachable

  mount_uploader :file, AttachedFileUploader

  def self.registered_attachable?(class_name)
    HasManyAttachedFiles.registered_attachable?(class_name)
  end

  def self.find_attachable(options)
    type = options[:type]
    id = options[:id].to_i

    raise "Unregistered type: '#{type}'" unless registered_attachable?(type)

    type.constantize.find(id)
  end

  private

  def token_or_attachable
    if !(token || attachable)
      self.errors[:base] << "Token OR Attachable required"
    end
  end

  def clear_token
    # Clear token is file has been attached to a persisted model
    self.token = nil
  end
end
