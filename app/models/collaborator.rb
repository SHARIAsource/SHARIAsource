class Collaborator < ActiveRecord::Base
  include HasManyAttachedFiles
  include RankedModel

  validates :name, presence: true
  ranks :sort_order
  has_many :users, dependent: :nullify
  mount_uploader :image, CollaboratorImageUploader

  validates :featured_library_position, allow_blank: true, inclusion: {
    in: 1..3,
    message: 'Must be between 1 and 3'
  }

  def self.featured
    where.not(featured_library_position: nil).order(:featured_library_position).limit(3)
  end

  def commentary_count
    self.users.joins(documents: :document_type).where(document_types: {
      name: 'Commentary'
    }).count
  end
end
