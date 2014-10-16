# == Schema Information
#
# Table name: collaborators
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string(255)
#  sort_order  :integer
#

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
