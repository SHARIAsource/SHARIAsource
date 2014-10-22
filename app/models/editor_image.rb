class EditorImage < ActiveRecord::Base
  validates :name, presence: true
  validates :image, presence: true
  mount_uploader :image, EditorImageUploader

  def serializable_hash(options)
    {
      title: self.name,
      value: self.image.url
    }
  end
end
