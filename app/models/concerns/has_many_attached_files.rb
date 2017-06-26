module HasManyAttachedFiles
  extend ActiveSupport::Concern

  mattr_accessor :registered_attachable_class_names

  def self.register_attachable(class_name)
    # Any class that includes this module will be registered as something
    # that is attachable. This is how we validate model class names we get
    # as strings from the Attached File upload forms.
    self.registered_attachable_class_names ||= Set.new
    self.registered_attachable_class_names << class_name
  end

  def self.registered_attachable?(class_name)
    return false unless self.registered_attachable_class_names

    self.registered_attachable_class_names.include? class_name
  end

  included do
    has_many :attached_files, as: :attachable
    attr_accessor :attached_file_token
    after_create :save_attached_files_with_token, if: :attached_file_token

    HasManyAttachedFiles.register_attachable(self.name)

    def save_attached_files_with_token
      self.attached_files << AttachedFile.where(token: attached_file_token)
    end
  end

end
