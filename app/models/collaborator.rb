class Collaborator < ActiveRecord::Base
  include RankedModel

  validates :name, presence: true
  ranks :sort_order
  has_many :users, dependent: :nullify
  mount_uploader :image, CollaboratorImageUploader

  def commentary_count
    self.users.joins(documents: :document_type).where(document_types: {
      name: 'Commentary'
    }).count
  end
end
