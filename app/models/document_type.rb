# == Schema Information
#
# Table name: document_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

class DocumentType < ActiveRecord::Base
  acts_as_tree order: 'name'
  validates :name, presence: true, uniqueness: true
  has_many :documents
end
